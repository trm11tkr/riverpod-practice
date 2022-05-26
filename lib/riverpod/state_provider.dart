import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// StateProvider example.
final counterProvider = StateProvider((ref) => 0);

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({
    super.key,
  });

  static String title = 'StateProvider';
  static String routeName = 'state-provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StateProviderを読み取る。 `.notifier` を付けると `StateController` が、
    // 付けなければ、 `state` つまり int が取得できる。
    final counter = ref.watch(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // counterProviderの状態（カウント数）をTextで表示
              Text(
                'Count: ${ref.watch(counterProvider)}',
                style: Theme.of(context).textTheme.headline2,
              ),
              ElevatedButton(
                // ボタンタップでcounterProviderの状態をプラス１する
                // ↓ `counter.state++` や、
                // ↓ `counter.state = counter.state + 1` と書いても同じ。
                onPressed: () => counter.update((state) => state + 1),
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}