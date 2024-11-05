import 'package:todo_flutter/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> addTodoItem(Todo todo);

  Future<List<Todo>> fetchTodoItems();

  Future<void> deleteTodoItem(String id);

  Future<void> toggleTodoItemCompletion(String id);
}
