import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteTodoItem(id);
  }
}
