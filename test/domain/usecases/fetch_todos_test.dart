import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/fetch_todos.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late FetchTodos fetchTodos;
  late MockTodoRepository mockTodoRepository;
  setUp(() {
    mockTodoRepository = MockTodoRepository();
    fetchTodos = FetchTodos(mockTodoRepository);
  });

  test(
      'should call fetchTodoItems on the repository and return a list of todos',
      () async {
    final todos = [
      Todo(
        id: '1',
        title: 'Test Todo 1',
        isCompleted: false,
      ),
      Todo(
        id: '2',
        title: 'Test Todo 1',
        isCompleted: false,
      ),
    ];
    when(mockTodoRepository.fetchTodoItems()).thenAnswer((_) async => todos);

    final result = await fetchTodos.call();

    expect(result, todos);
    verify(mockTodoRepository.fetchTodoItems()).called(1);
  });
}
