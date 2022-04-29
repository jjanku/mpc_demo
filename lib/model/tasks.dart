import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../native/generated/mpc_sigs_lib.dart';
import '../native/worker.dart';
import '../util/uuid.dart';
import 'group.dart';
import 'signed_file.dart';

enum TaskStatus { unapproved, waiting, finished }

abstract class MpcTask {
  Uuid id;
  TaskStatus _status = TaskStatus.unapproved;
  int _round = 0;
  late final Worker _worker;

  MpcTask(this.id);

  Future<List<int>?> update(int round, List<int> data) async {
    if (round <= _round) return null;
    _round = round;
    // FIXME: this is safe as long as the round we receive is correct

    if (_round == 1) await _initWorker();

    final ProtocolUpdate resp = await _worker.enqueueRequest(
      // FIXME: change types
      ProtocolUpdate(data as Uint8List),
    );

    return resp.data.materialize().asUint8List();
  }

  Future<void> _initWorker();

  Future<void> finish(List<int> data);

  void approve() => _status = TaskStatus.waiting;
  TaskStatus get status => _status;
}

class GroupTask extends MpcTask {
  final Group group;

  GroupTask(Uuid uuid, this.group) : super(uuid);

  @override
  Future<void> _initWorker() async {
    _worker = Worker(
      GroupWorkerThread.entryPoint,
      debugName: 'group worker',
    );
    await _worker.start();
    await _worker.enqueueRequest(GroupInitMsg(Algorithm.Gg18));
  }

  @override
  Future<void> finish(List<int> data) async {
    if (_status == TaskStatus.finished) return;
    _status = TaskStatus.finished;

    await _worker.enqueueRequest(TaskFinishMsg());
    _worker.stop();
    // FIXME: when to do copy when receiving data using grpc?
    // group.context = mpcLib.protocol_result_group(_proto);
    group.id = data;
  }
}

class SignTask extends MpcTask {
  final SignedFile file;

  SignTask(Uuid uuid, this.file) : super(uuid);

  @override
  Future<void> _initWorker() {
    // TODO: implement _initWorker
    throw UnimplementedError();
  }

  @override
  Future<void> finish(List<int> data) async {
    // TODO: implement finish
    if (_status == TaskStatus.finished) return;
    _status = TaskStatus.finished;

    file.isFinished = true;
  }
}

class GroupInitMsg {
  int algorithm;
  GroupInitMsg(this.algorithm);
}

class ProtocolUpdate {
  TransferableTypedData data;

  ProtocolUpdate(Uint8List bytes)
      : data = TransferableTypedData.fromList([bytes]);
}

class TaskFinishMsg {}

final MpcSigsLib mpcLib = MpcSigsLib(dlOpen('mpc_sigs'));

abstract class TaskWorkerThread extends WorkerThread {
  Pointer<ProtoWrapper> _proto = nullptr;

  TaskWorkerThread(SendPort sendPort) : super(sendPort);

  ProtocolUpdate _updateProtocol(ProtocolUpdate update) {
    assert(_proto != nullptr);
    final data = update.data.materialize().asUint8List();

    // TODO: can we avoid some of these copies?
    return using((Arena alloc) {
      final buf = alloc<Uint8>(data.length);
      buf.asTypedList(data.length).setAll(0, data);

      print('update protocol');
      final outBuf = mpcLib.protocol_update(_proto, buf, data.length);

      return ProtocolUpdate(
        outBuf.ptr.asTypedList(outBuf.len),
      );
    });
  }
}

class GroupWorkerThread extends TaskWorkerThread {
  GroupWorkerThread(SendPort sendPort) : super(sendPort);

  @override
  handleMessage(message) {
    if (message is GroupInitMsg) return _init(message);
    if (message is ProtocolUpdate) return _updateProtocol(message);
    if (message is TaskFinishMsg) return _finish();
    assert(false);
  }

  void _init(GroupInitMsg message) {
    _proto = mpcLib.protocol_new(message.algorithm);
  }

  void _finish() {}

  static void entryPoint(SendPort sendPort) {
    GroupWorkerThread(sendPort);
  }
}
