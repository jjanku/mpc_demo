///
//  Generated code. Do not modify.
//  source: mpc.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use protocolDescriptor instead')
const Protocol$json = const {
  '1': 'Protocol',
  '2': const [
    const {'1': 'GG18', '2': 0},
  ],
};

/// Descriptor for `Protocol`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List protocolDescriptor =
    $convert.base64Decode('CghQcm90b2NvbBIICgRHRzE4EAA=');
@$core.Deprecated('Use registrationRequestDescriptor instead')
const RegistrationRequest$json = const {
  '1': 'RegistrationRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `RegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registrationRequestDescriptor = $convert.base64Decode(
    'ChNSZWdpc3RyYXRpb25SZXF1ZXN0Eg4KAmlkGAEgASgMUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use groupRequestDescriptor instead')
const GroupRequest$json = const {
  '1': 'GroupRequest',
  '2': const [
    const {'1': 'device_ids', '3': 1, '4': 3, '5': 12, '10': 'deviceIds'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'threshold',
      '3': 3,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'threshold',
      '17': true
    },
    const {
      '1': 'protocol',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.meesign.Protocol',
      '9': 1,
      '10': 'protocol',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_threshold'},
    const {'1': '_protocol'},
  ],
};

/// Descriptor for `GroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupRequestDescriptor = $convert.base64Decode(
    'CgxHcm91cFJlcXVlc3QSHQoKZGV2aWNlX2lkcxgBIAMoDFIJZGV2aWNlSWRzEhIKBG5hbWUYAiABKAlSBG5hbWUSIQoJdGhyZXNob2xkGAMgASgNSABSCXRocmVzaG9sZIgBARIyCghwcm90b2NvbBgEIAEoDjIRLm1lZXNpZ24uUHJvdG9jb2xIAVIIcHJvdG9jb2yIAQFCDAoKX3RocmVzaG9sZEILCglfcHJvdG9jb2w=');
@$core.Deprecated('Use groupDescriptor instead')
const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'threshold', '3': 3, '4': 1, '5': 13, '10': 'threshold'},
    const {'1': 'device_ids', '3': 4, '4': 3, '5': 12, '10': 'deviceIds'},
  ],
};

/// Descriptor for `Group`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode(
    'CgVHcm91cBIOCgJpZBgBIAEoDFICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIcCgl0aHJlc2hvbGQYAyABKA1SCXRocmVzaG9sZBIdCgpkZXZpY2VfaWRzGAQgAygMUglkZXZpY2VJZHM=');
@$core.Deprecated('Use devicesRequestDescriptor instead')
const DevicesRequest$json = const {
  '1': 'DevicesRequest',
};

/// Descriptor for `DevicesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicesRequestDescriptor =
    $convert.base64Decode('Cg5EZXZpY2VzUmVxdWVzdA==');
@$core.Deprecated('Use devicesDescriptor instead')
const Devices$json = const {
  '1': 'Devices',
  '2': const [
    const {
      '1': 'devices',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.meesign.Device',
      '10': 'devices'
    },
  ],
};

/// Descriptor for `Devices`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List devicesDescriptor = $convert.base64Decode(
    'CgdEZXZpY2VzEikKB2RldmljZXMYASADKAsyDy5tZWVzaWduLkRldmljZVIHZGV2aWNlcw==');
@$core.Deprecated('Use deviceDescriptor instead')
const Device$json = const {
  '1': 'Device',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Device`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDescriptor = $convert.base64Decode(
    'CgZEZXZpY2USDgoCaWQYASABKAxSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use signRequestDescriptor instead')
const SignRequest$json = const {
  '1': 'SignRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 12, '10': 'groupId'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `SignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signRequestDescriptor = $convert.base64Decode(
    'CgtTaWduUmVxdWVzdBIZCghncm91cF9pZBgBIAEoDFIHZ3JvdXBJZBISCgRkYXRhGAIgASgMUgRkYXRh');
@$core.Deprecated('Use taskRequestDescriptor instead')
const TaskRequest$json = const {
  '1': 'TaskRequest',
  '2': const [
    const {'1': 'task_id', '3': 1, '4': 1, '5': 12, '10': 'taskId'},
    const {
      '1': 'device_id',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'deviceId',
      '17': true
    },
  ],
  '8': const [
    const {'1': '_device_id'},
  ],
};

/// Descriptor for `TaskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskRequestDescriptor = $convert.base64Decode(
    'CgtUYXNrUmVxdWVzdBIXCgd0YXNrX2lkGAEgASgMUgZ0YXNrSWQSIAoJZGV2aWNlX2lkGAIgASgMSABSCGRldmljZUlkiAEBQgwKCl9kZXZpY2VfaWQ=');
@$core.Deprecated('Use taskDescriptor instead')
const Task$json = const {
  '1': 'Task',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    const {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.meesign.Task.TaskType',
      '10': 'type'
    },
    const {
      '1': 'state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.meesign.Task.TaskState',
      '10': 'state'
    },
    const {'1': 'round', '3': 4, '4': 1, '5': 13, '10': 'round'},
    const {
      '1': 'data',
      '3': 5,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'data',
      '17': true
    },
  ],
  '4': const [Task_TaskType$json, Task_TaskState$json],
  '8': const [
    const {'1': '_data'},
  ],
};

@$core.Deprecated('Use taskDescriptor instead')
const Task_TaskType$json = const {
  '1': 'TaskType',
  '2': const [
    const {'1': 'GROUP', '2': 0},
    const {'1': 'SIGN', '2': 1},
  ],
};

@$core.Deprecated('Use taskDescriptor instead')
const Task_TaskState$json = const {
  '1': 'TaskState',
  '2': const [
    const {'1': 'CREATED', '2': 0},
    const {'1': 'RUNNING', '2': 1},
    const {'1': 'FINISHED', '2': 2},
    const {'1': 'FAILED', '2': 3},
  ],
};

/// Descriptor for `Task`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskDescriptor = $convert.base64Decode(
    'CgRUYXNrEg4KAmlkGAEgASgMUgJpZBIqCgR0eXBlGAIgASgOMhYubWVlc2lnbi5UYXNrLlRhc2tUeXBlUgR0eXBlEi0KBXN0YXRlGAMgASgOMhcubWVlc2lnbi5UYXNrLlRhc2tTdGF0ZVIFc3RhdGUSFAoFcm91bmQYBCABKA1SBXJvdW5kEhcKBGRhdGEYBSABKAxIAFIEZGF0YYgBASIfCghUYXNrVHlwZRIJCgVHUk9VUBAAEggKBFNJR04QASI/CglUYXNrU3RhdGUSCwoHQ1JFQVRFRBAAEgsKB1JVTk5JTkcQARIMCghGSU5JU0hFRBACEgoKBkZBSUxFRBADQgcKBV9kYXRh');
@$core.Deprecated('Use taskUpdateDescriptor instead')
const TaskUpdate$json = const {
  '1': 'TaskUpdate',
  '2': const [
    const {'1': 'device', '3': 1, '4': 1, '5': 12, '10': 'device'},
    const {'1': 'task', '3': 2, '4': 1, '5': 12, '10': 'task'},
    const {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `TaskUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskUpdateDescriptor = $convert.base64Decode(
    'CgpUYXNrVXBkYXRlEhYKBmRldmljZRgBIAEoDFIGZGV2aWNlEhIKBHRhc2sYAiABKAxSBHRhc2sSEgoEZGF0YRgDIAEoDFIEZGF0YQ==');
@$core.Deprecated('Use tasksRequestDescriptor instead')
const TasksRequest$json = const {
  '1': 'TasksRequest',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 12, '10': 'deviceId'},
  ],
};

/// Descriptor for `TasksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tasksRequestDescriptor = $convert.base64Decode(
    'CgxUYXNrc1JlcXVlc3QSGwoJZGV2aWNlX2lkGAEgASgMUghkZXZpY2VJZA==');
@$core.Deprecated('Use tasksDescriptor instead')
const Tasks$json = const {
  '1': 'Tasks',
  '2': const [
    const {
      '1': 'tasks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.meesign.Task',
      '10': 'tasks'
    },
  ],
};

/// Descriptor for `Tasks`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tasksDescriptor = $convert.base64Decode(
    'CgVUYXNrcxIjCgV0YXNrcxgBIAMoCzINLm1lZXNpZ24uVGFza1IFdGFza3M=');
@$core.Deprecated('Use groupsRequestDescriptor instead')
const GroupsRequest$json = const {
  '1': 'GroupsRequest',
  '2': const [
    const {'1': 'device_id', '3': 1, '4': 1, '5': 12, '10': 'deviceId'},
  ],
};

/// Descriptor for `GroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsRequestDescriptor = $convert.base64Decode(
    'Cg1Hcm91cHNSZXF1ZXN0EhsKCWRldmljZV9pZBgBIAEoDFIIZGV2aWNlSWQ=');
@$core.Deprecated('Use groupsDescriptor instead')
const Groups$json = const {
  '1': 'Groups',
  '2': const [
    const {
      '1': 'groups',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.meesign.Group',
      '10': 'groups'
    },
  ],
};

/// Descriptor for `Groups`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupsDescriptor = $convert.base64Decode(
    'CgZHcm91cHMSJgoGZ3JvdXBzGAEgAygLMg4ubWVlc2lnbi5Hcm91cFIGZ3JvdXBz');
@$core.Deprecated('Use respDescriptor instead')
const Resp$json = const {
  '1': 'Resp',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'success'},
    const {'1': 'failure', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'failure'},
  ],
  '8': const [
    const {'1': 'variant'},
  ],
};

/// Descriptor for `Resp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List respDescriptor = $convert.base64Decode(
    'CgRSZXNwEhoKB3N1Y2Nlc3MYASABKAlIAFIHc3VjY2VzcxIaCgdmYWlsdXJlGAIgASgJSABSB2ZhaWx1cmVCCQoHdmFyaWFudA==');
@$core.Deprecated('Use taskAgreementDescriptor instead')
const TaskAgreement$json = const {
  '1': 'TaskAgreement',
  '2': const [
    const {'1': 'agreement', '3': 1, '4': 1, '5': 8, '10': 'agreement'},
  ],
};

/// Descriptor for `TaskAgreement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskAgreementDescriptor = $convert.base64Decode(
    'Cg1UYXNrQWdyZWVtZW50EhwKCWFncmVlbWVudBgBIAEoCFIJYWdyZWVtZW50');
@$core.Deprecated('Use taskAcknowledgementDescriptor instead')
const TaskAcknowledgement$json = const {
  '1': 'TaskAcknowledgement',
};

/// Descriptor for `TaskAcknowledgement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taskAcknowledgementDescriptor =
    $convert.base64Decode('ChNUYXNrQWNrbm93bGVkZ2VtZW50');
