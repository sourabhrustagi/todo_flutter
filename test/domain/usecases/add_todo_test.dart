import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/add_todo.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late AddTodo addTodo;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    addTodo = AddTodo(mockTodoRepository);
  });

  test('should call addTodoItem on the repository', () async {
    final todo = Todo(
      id: '1',
      title: 'Test Todo',
      isCompleted: false,
    );

    when(mockTodoRepository.addTodoItem(todo))
        .thenAnswer((_) async => Future.value());

    await addTodo.call(todo);

    verify(mockTodoRepository.addTodoItem(todo)).called(1);
  });
}
