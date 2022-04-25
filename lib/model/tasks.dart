import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import '../native/dylib_worker.dart';
import '../native/generated/mpc_sigs_lib.dart';

import '../util/uuid.dart';
import 'group.dart';
import 'signed_file.dart';

enum TaskStatus { unapproved, waiting, finished }

final MpcSigsLib mpcLib = MpcSigsLib(dlOpen('mpc_sigs'));

abstract class MpcTask {
  Uuid id;
  TaskStatus _status = TaskStatus.unapproved;
  int _round = 0;

  MpcTask(this.id);

  Future<List<int>?> update(int round, List<int> data);
  Future<void> finish(List<int> data);

  void approve() => _status = TaskStatus.waiting;
  TaskStatus get status => _status;
}

// TODO: need to rethink this in terms of persistence
// should we spawn a new worker for each task hoping it'll finish soon enough?
// should we serialize/deserialize the context in each update?

class GroupTask extends MpcTask {
  final Group group;

  Pointer<ProtoWrapper> _proto;

  GroupTask(Uuid uuid, this.group)
      : _proto = mpcLib.protocol_new(Algorithm.Gg18),
        super(uuid) {
    assert(_proto != nullptr);
  }

  @override
  Future<List<int>?> update(int round, List<int> data) async {
    if (round <= _round) return null;
    _round = round;
    // FIXME: this is safe as long as the round we receive is correct

    final resp = await compute(
      _updateProtocol,
      ProtocolUpdate(_proto.address, data as Uint8List),
    );
    _proto = Pointer<ProtoWrapper>.fromAddress(resp.protoAddr);
    return resp.data.materialize().asUint8List();
  }

  @override
  Future<void> finish(List<int> data) async {
    if (_status == TaskStatus.finished) return;
    _status = TaskStatus.finished;

    // FIXME: when to do copy when receiving data using grpc?
    group.context = mpcLib.protocol_result_group(_proto);
    group.id = data;

    mpcLib.protocol_free(_proto);
    _proto = nullptr;
  }
}

class SignTask extends MpcTask {
  final SignedFile file;

  SignTask(Uuid uuid, this.file) : super(uuid);

  @override
  Future<List<int>?> update(int round, List<int> data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> finish(List<int> data) {
    // TODO: implement finish
    throw UnimplementedError();
  }
}

class ProtocolUpdate {
  int protoAddr;
  TransferableTypedData data;

  ProtocolUpdate(this.protoAddr, Uint8List bytes)
      : data = TransferableTypedData.fromList([bytes]);
}

ProtocolUpdate _updateProtocol(ProtocolUpdate update) {
  final data = update.data.materialize().asUint8List();

  // TODO: can we avoid some of these copies?
  return using((Arena alloc) {
    final buf = alloc<Uint8>(data.length);
    buf.asTypedList(data.length).setAll(0, data);

    var proto = Pointer<ProtoWrapper>.fromAddress(update.protoAddr);
    assert(proto != nullptr);

    print('isolate: advance keygen');
    final outBuf = mpcLib.protocol_update(proto, buf, data.length);

    return ProtocolUpdate(
      proto.address,
      outBuf.ptr.asTypedList(outBuf.len),
    );
  });
}
