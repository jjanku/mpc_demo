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

    final TransferableTypedData trans =
        await _worker.enqueueRequest(TaskFinishMsg());

    // FIXME: when to do copy when receiving data using grpc?
    // group.context = mpcLib.protocol_result_group(_proto);
    group.id = data;
    group.context = trans.materialize().asUint8List();

    _worker.stop();
  }
}

class SignTask extends MpcTask {
  final SignedFile file;

  SignTask(Uuid uuid, this.file) : super(uuid);

  @override
  Future<void> _initWorker() async {
    _worker = Worker(
      SignWorkerThread.entryPoint,
      debugName: 'sign worker',
    );
    await _worker.start();
    await _worker.enqueueRequest(
      SignInitMsg(Algorithm.Gg18, file.group.context!, file.path),
    );
  }

  @override
  Future<void> finish(List<int> data) async {
    // TODO: implement finish
    if (_status == TaskStatus.finished) return;
    _status = TaskStatus.finished;

    await _worker.enqueueRequest(TaskFinishMsg());

    file.isFinished = true;

    _worker.stop();
  }
}

class GroupInitMsg {
  int algorithm;
  GroupInitMsg(this.algorithm);
}

class PayloadMsg {
  TransferableTypedData _data;

  PayloadMsg(Uint8List data) : _data = TransferableTypedData.fromList([data]);

  Uint8List deliver() => _data.materialize().asUint8List();
}

// TODO: make classes with TransData extend PayloadMsg

class SignInitMsg {
  int algorithm;
  TransferableTypedData groupData;
  String path;

  SignInitMsg(this.algorithm, Uint8List groupData, this.path)
      : groupData = TransferableTypedData.fromList([groupData]);
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

      // FIXME: handle errors
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

  // TODO: add wrapper class?
  TransferableTypedData _finish() {
    final buf = mpcLib.protocol_result(_proto);
    final trans = TransferableTypedData.fromList(
      [buf.ptr.asTypedList(buf.len)],
    );

    mpcLib.protocol_free(_proto);
    _proto = nullptr;

    return trans;
  }

  static void entryPoint(SendPort sendPort) {
    GroupWorkerThread(sendPort);
  }
}

class SignWorkerThread extends TaskWorkerThread {
  SignWorkerThread(SendPort sendPort) : super(sendPort);

  @override
  handleMessage(message) {
    if (message is SignInitMsg) return _init(message);
    if (message is ProtocolUpdate) return _updateProtocol(message);
    if (message is TaskFinishMsg) return _finish();
  }

  void _init(SignInitMsg message) {
    // TODO: same as above, how to avoid copies?
    final data = message.groupData.materialize().asUint8List();
    using((Arena alloc) {
      final buf = alloc<Uint8>(data.length);
      buf.asTypedList(data.length).setAll(0, data);
      _proto = mpcLib.group_sign(message.algorithm, buf, data.length);
    });
  }

  void _finish() {
    // TODO: insert signature
    mpcLib.protocol_free(_proto);
  }

  static void entryPoint(SendPort sendPort) {
    SignWorkerThread(sendPort);
  }
}
