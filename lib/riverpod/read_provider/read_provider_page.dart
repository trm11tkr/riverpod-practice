import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider counterProvider = StateProvider<int>((ref) => 0);
class ReadProviderPage extends ConsumerWidget {
  const ReadProviderPage({Key? key}) : super(key: key);
  static String title = 'Read Provider';
  static String routeName = 'read-provider';

  /// watch: 更新されたProviderデータ取得 & ビューに反映(更新)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return ElevatedButton(
      onPressed: () => ref.watch(counterProvider.notifier).state++,
      child: Text('変化あり: $counter')
    );

  // /// watch: 更新されたProviderデータ取得 & ビューに反映(更新)
  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return ElevatedButton(
  //     onPressed: () => ref.read(counterProvider.notifier).state++,
  //     child: Text('変化なし: ${ref.read(counterProvider)}')
  //   );
  }
}
