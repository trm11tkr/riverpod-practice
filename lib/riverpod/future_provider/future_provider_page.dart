import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final configProvider = FutureProvider<Map<String, Object?>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/config.json');
  final content = json.decode(jsonString) as Map<String, Object?>;
  return content;
});

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureProviderを読み取る（取得できる型は `AsyncValue<T>`）
    final AsyncValue<Map<String, dynamic>> config = ref.watch(configProvider);

    return Scaffold(
      // AsyncValue は `.when` を使ってハンドリングする
      body: config.when(
        // 非同期処理中は `loading` で指定したWidgetが表示される
        loading: () => const CircularProgressIndicator(),
        // エラーが発生した場合に表示されるWidgetを指定
        error: (error, stack) => Center(child: Text('Error: $error')),
        // 非同期処理が完了すると、取得した `config` が `data` で使用できる
        data: (config) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(config['id'].toString()),
                Text(config['title']),
                Text(config['defaultAge'].toString()),
                Text(config['city'].toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}
