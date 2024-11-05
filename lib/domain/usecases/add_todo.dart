import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(Todo todo) async {
    return await repository.addTodoItem(todo);
  }
}
