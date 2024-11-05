import 'package:todo_flutter/data/datasources/local_todo_datasource.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalTodoDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<void> addTodoItem(Todo todo) async {
    await dataSource.addTodoItem(todo);
  }

  @override
  Future<void> deleteTodoItem(String id) async {
    return await dataSource.deleteTodoItem(id);
  }

  @override
  Future<List<Todo>> fetchTodoItems() async {
    return await dataSource.fetchTodoItems();
  }

  @override
  Future<void> toggleTodoItemCompletion(String id) async {
    await dataSource.toggleTodoItemCompletion(id);
  }
}
