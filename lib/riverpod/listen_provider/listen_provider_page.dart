import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provider example.
final counterProvider = StateProvider((ref) => 0);

// Widget example.
class ListenProviderPage extends ConsumerWidget {
  const ListenProviderPage({super.key});

  static String title = 'Listen Provider';
  static String routeName = 'listen-provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerを購読する
    ref.listen<int>(
      counterProvider,
          (previous, next) {
        // Counterの数値が奇数になったときにだけダイアログを表示する
        if (next.isOdd) {
          return;
        }
        showDialog<void>(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Current number is Odd !!'),
            );
          },
        );
      },
      // エラーハンドリング（省略可能）
      onError: (error, stackTrace) => debugPrint('$error'),
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  onPressed: () => ref
                      .read(counterProvider.notifier)
                      .update((state) => state + 1),
                  child: const Text('Increment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}