// ignore_for_file: non_constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Bindings to mpc-sigs C API
class MpcSigsLib {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  MpcSigsLib(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  MpcSigsLib.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int increment(
    int i,
  ) {
    return _increment(
      i,
    );
  }

  late final _incrementPtr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Int32)>>('increment');
  late final _increment = _incrementPtr.asFunction<int Function(int)>();

  ffi.Pointer<ffi.Int8> to_cstring(
    int num,
  ) {
    return _to_cstring(
      num,
    );
  }

  late final _to_cstringPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Int8> Function(ffi.Int32)>>(
          'to_cstring');
  late final _to_cstring =
      _to_cstringPtr.asFunction<ffi.Pointer<ffi.Int8> Function(int)>();

  int free_cstring(
    ffi.Pointer<ffi.Int8> num_cstr,
  ) {
    return _free_cstring(
      num_cstr,
    );
  }

  late final _free_cstringPtr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Int8>)>>(
          'free_cstring');
  late final _free_cstring =
      _free_cstringPtr.asFunction<int Function(ffi.Pointer<ffi.Int8>)>();

  void print_cstring(
    ffi.Pointer<ffi.Int8> text,
  ) {
    return _print_cstring(
      text,
    );
  }

  late final _print_cstringPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Int8>)>>(
          'print_cstring');
  late final _print_cstring =
      _print_cstringPtr.asFunction<void Function(ffi.Pointer<ffi.Int8>)>();

  ffi.Pointer<RObject> robject_new() {
    return _robject_new();
  }

  late final _robject_newPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<RObject> Function()>>(
          'robject_new');
  late final _robject_new =
      _robject_newPtr.asFunction<ffi.Pointer<RObject> Function()>();

  void robject_change(
    ffi.Pointer<RObject> p,
  ) {
    return _robject_change(
      p,
    );
  }

  late final _robject_changePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<RObject>)>>(
          'robject_change');
  late final _robject_change =
      _robject_changePtr.asFunction<void Function(ffi.Pointer<RObject>)>();

  void robject_free(
    ffi.Pointer<RObject> p,
  ) {
    return _robject_free(
      p,
    );
  }

  late final _robject_freePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<RObject>)>>(
          'robject_free');
  late final _robject_free =
      _robject_freePtr.asFunction<void Function(ffi.Pointer<RObject>)>();
}

class RObject extends ffi.Opaque {}