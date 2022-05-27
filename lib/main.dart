import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/riverpod/future_provider/future_provider_page.dart';
import 'package:riverpod_practice/riverpod/listen_provider/listen_provider_page.dart';
import 'package:riverpod_practice/riverpod/provider_page.dart';
import 'package:riverpod_practice/riverpod/refresh_provider/refresh_provider_page.dart';
import 'package:riverpod_practice/riverpod/state_notifier_provider/state_notifier_provider_page.dart';
import 'package:riverpod_practice/riverpod/state_provider_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: const RefreshProviderPage(),
    );
  }
}
