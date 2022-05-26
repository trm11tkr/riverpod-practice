import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/riverpod/state_notifier_provider/entities/todo.dart';

final todoListNotifierProvider =
StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier()
      : super(const [
    // サンプルのTodoを挿入
    Todo(id: '1', title: 'todo1'),
    Todo(id: '2', title: 'todo2'),
    Todo(id: '3', title: 'todo3'),
    Todo(id: '4', title: 'todo4'),
    Todo(id: '5', title: 'todo5'),
  ]);

  /// 新しいTODOを追加するメソッド
  void add(Todo todo) {
    state = [...state, todo];
  }

  /// IDを指定して、TODOを削除するメソッド
  void remove(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  /// IDを指定して、TODOの完了状態を切り替えるメソッド
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }
}