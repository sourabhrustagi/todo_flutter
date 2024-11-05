import 'package:todo_flutter/domain/entities/todo.dart';

class LocalTodoDataSource {
  final List<Todo> _todoList = [];

  Future<void> addTodoItem(Todo todo) async {
    _todoList.add(todo);
  }

  Future<List<Todo>> fetchTodoItems() async {
    return _todoList;
  }

  Future<void> deleteTodoItem(String id) async {
    _todoList.removeWhere((todo) => todo.id == id);
  }

  Future<void> toggleTodoItemCompletion(String id) async {
    int index = _todoList.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todoList[index] = Todo(
        id: _todoList[index].id,
        title: _todoList[index].title,
        isCompleted: !_todoList[index].isCompleted,
      );
    }
  }
}
