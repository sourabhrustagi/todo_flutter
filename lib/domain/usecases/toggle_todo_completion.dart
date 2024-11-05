import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class ToggleTodoCompletion {
  final TodoRepository repository;

  ToggleTodoCompletion(this.repository);

  Future<void> call(String id) async {
    return await repository.toggleTodoItemCompletion(id);
  }
}
