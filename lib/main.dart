import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mpc_demo/native/mpc_sigs_lib.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Counter(),
    child: const MyApp(),
  ));
}

String dlPlatformName(String name) {
  if (Platform.isAndroid || Platform.isLinux) return 'lib$name.so';
  if (Platform.isWindows) return '$name.dll';
  if (Platform.isMacOS) return '$name.dylib';
  throw Exception('Platform unsupported');
}

DynamicLibrary dlOpen(String name) {
  if (Platform.isLinux) return DynamicLibrary.process();
  return DynamicLibrary.open(dlPlatformName(name));
}

class Counter with ChangeNotifier {
  final MpcSigsLib lib = MpcSigsLib(dlOpen('mpc_sigs'));
  int value = 0;

  void increment() {
    value = lib.increment(value);

    final cstr = lib.to_cstring(value);
    final str = cstr.cast<Utf8>().toDartString();
    print(str);
    final parsedNum = lib.free_cstring(cstr);
    assert(parsedNum == value);

    final text = 'Goodbye world'.toNativeUtf8();
    lib.print_cstring(text.cast<Int8>());
    malloc.free(text);

    final robj = lib.robject_new();
    lib.robject_change(robj);
    lib.robject_free(robj);

    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var counter = context.read<Counter>();
          counter.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
