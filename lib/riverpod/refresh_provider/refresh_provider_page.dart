import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final _githubUserProvider = FutureProvider<Map<String, Object?>>((ref) async {
  const String username = 'trm11tkr';
  final response = await http.get(Uri.https(
    'api.github.com',
    'users/$username',
  ));
  return json.decode(response.body);
});

class RefreshProviderPage extends ConsumerWidget {
  const RefreshProviderPage({Key? key}) : super(key: key);

  static const String title = 'refreshProvider';
  static const String routeName = 'refresh-provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map<String, Object?>? 型となるので、 利用時にnullチェックが必要
    final AsyncValue<Map<String, Object?>?> user =
        ref.watch(_githubUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          IconButton(
              onPressed: () async => ref.refresh(_githubUserProvider),
              icon: const Icon(Icons.refresh,),
          )
        ],
      ),
      body: user.when(
        // 非同期処理実行中はインジケーターを表示
        loading: () => const Center(child: CircularProgressIndicator()),
        // エラーが発生した場合はエラー情報を表示
        error: (error, stack) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async => ref.refresh(_githubUserProvider),
                    child: const Icon(Icons.refresh),
                ),
                Expanded(
                    child: SingleChildScrollView(child: Text('Error: $error, $stack'))),

              ],
            ),
          );
        },
        // 非同期処理が完了したら `data` プロパティの引数として受け取れる。
        data: (user) {
          return RefreshIndicator(
            // RefreshIndicatorでListView等を囲み、 `onRefresh` で動作を指定すれば引っ張って更新できるようになる
            // `ref.refresh()` でProviderを更新
            onRefresh: () async => ref.refresh(_githubUserProvider),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                ListTile(
                  title: const Text('login'),
                  subtitle: Text('${user!['login'] ?? 'none'}'),
                ),
                ListTile(
                  title: const Text('id'),
                  subtitle: Text('${user['id'] ?? 'none'}'),
                ),
                ListTile(
                  title: const Text('html_url'),
                  subtitle: Text('${user['html_url'] ?? 'none'}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
