import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter/data/datasources/local_todo_datasource.dart';
import 'package:todo_flutter/domain/entities/todo.dart';

void main() {
  group('LocalTodoDataSource', () {
    late LocalTodoDataSource dataSource;
    setUp(() {
      dataSource = LocalTodoDataSource();
    });

    test('should add a todo item', () async {
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        isCompleted: false,
      );

      await dataSource.addTodoItem(todo);
      final todos = await dataSource.fetchTodoItems();

      expect(todos, contains(todo));
    });

    test('should fetch all todo items', () async {
      final todo1 = Todo(
        id: '1',
        title: 'Test todo 1',
        isCompleted: false,
      );
      final todo2 = Todo(
        id: '2',
        title: 'Test todo 2',
        isCompleted: true,
      );

      await dataSource.addTodoItem(todo1);
      await dataSource.addTodoItem(todo2);

      final todos = await dataSource.fetchTodoItems();
      expect(todos, containsAll([todo1, todo2]));
    });

    test('should delete a todo item', () async {
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        isCompleted: false,
      );

      await dataSource.addTodoItem(todo);
      await dataSource.deleteTodoItem(todo.id);
      final todos = await dataSource.fetchTodoItems();

      expect(todos, isNot(contains(todo)));
    });

    test('should toggle todo item completion', () async {
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        isCompleted: false,
      );

      await dataSource.addTodoItem(todo);
      await dataSource.toggleTodoItemCompletion(todo.id);
      final todos = await dataSource.fetchTodoItems();

      expect(todos.first.isCompleted, isTrue);
    });
  });
}
