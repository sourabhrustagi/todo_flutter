import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/data/datasources/local_todo_datasource.dart';
import 'package:todo_flutter/data/repositories/todo_repository_impl.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

import 'todo_repository_test.mocks.dart';

@GenerateMocks([LocalTodoDataSource])
void main() {
  late TodoRepository repository;
  late MockLocalTodoDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockLocalTodoDataSource();
    repository = TodoRepositoryImpl(mockDataSource);
  });

  test('should add a todo item', () async {
    const todo = Todo(
      id: '1',
      title: 'Test Todo',
      isCompleted: false,
    );

    when(mockDataSource.addTodoItem(todo)).thenAnswer((_) async => Future.value());

    await repository.addTodoItem(todo);

    verify(mockDataSource.addTodoItem(todo)).called(1);
  });

  test('should delete a todo item', () async {
    const id = '1';

    when(mockDataSource.deleteTodoItem(id)).thenAnswer((_) async => Future.value());

    await repository.deleteTodoItem(id);

    verify(mockDataSource.deleteTodoItem(id)).called(1);
  });

  test('should fetch all todo items', () async {
    final todos = [
      const Todo(
        id: '1',
        title: 'Test Todo 1',
        isCompleted: false,
      ),
      const Todo(
        id: '2',
        title: 'Test Todo 2',
        isCompleted: true,
      ),
    ];

    when(mockDataSource.fetchTodoItems()).thenAnswer((_) async => todos);

    final result = await repository.fetchTodoItems();

    expect(result, todos);
    verify(mockDataSource.fetchTodoItems()).called(1);
  });

  test('should toggle todo item completion', () async {
    const id = '1';

    when(mockDataSource.toggleTodoItemCompletion(id)).thenAnswer((_) async => Future.value());

    await repository.toggleTodoItemCompletion(id);

    verify(mockDataSource.toggleTodoItemCompletion(id)).called(1);
  });
}