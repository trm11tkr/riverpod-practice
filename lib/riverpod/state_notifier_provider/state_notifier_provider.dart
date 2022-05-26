import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'entities/todo_list_notitifer.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({
    super.key,
  });

  static const String title = 'StateNotifierProvider';
  static const String routeName = 'state-notifier-provider';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StateNotifierProviderを読み取る。watchを使用しているので、
    // state（状態）であるTODOリストが更新されると、buildメソッドが再実行されて画面が更新される
    final todoList = ref.watch(todoListNotifierProvider);
    // TodoListNotifier を使用する場合は `.notifier` を付けてProviderを読み取る
    final notifier = ref.watch(todoListNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return ListTile(
                  // TodoのタイトルをTextで表示
                  title: Text(todo.title),
                  leading: Icon(
                    todo.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  trailing: TextButton(
                    onPressed: () => notifier.remove(todo.id),
                    child: const Text('Delete'),
                  ),
                  // タップでTODOの完了状態を切り替える
                  onTap: () => notifier.toggle(todo.id),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            width: double.infinity,
            color: Colors.blue,
            child: const Text('完了済み'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                // isCompleted = trueのTODOだけ表示
                return todo.isCompleted
                    ? ListTile(
                        // TodoのタイトルをTextで表示
                        title: Text(todo.title),
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
