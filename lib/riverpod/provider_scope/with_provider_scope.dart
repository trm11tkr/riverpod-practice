import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// indexを読み取る予定なので初期値は持たない
// → エラーを投げる(後からoverridesで上書きされるため心配なし)
final currentIndex = Provider<int>((_) => throw UnimplementedError());

// nullを許容する記述方法もある
// final currentIndex = Provider<int?>((_) => null);

class WithProviderScopePage extends StatelessWidget {
  const WithProviderScopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) {
            return ProviderScope(
              // overridesで上書きが可能(本来ベーシックなProviderは外部から変更できない)
              overrides: [
                currentIndex.overrideWithValue(index),
              ],
              // constでインスタンス化できる
              child: const ConstItemTile(),
            );
          }
      ),
    );
  }
}

class ConstItemTile extends ConsumerWidget {
  const ConstItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(currentIndex);
    return ListTile(title: Text('$index番目のitem'));
  }
}
