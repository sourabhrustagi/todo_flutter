import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/delete_todo.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late DeleteTodo deleteTodo;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    deleteTodo = DeleteTodo(mockTodoRepository);
  });

  test('should call deleteTodoItem on the repository', () async {
    const todoId = '1';
    when(mockTodoRepository.deleteTodoItem(todoId))
        .thenAnswer((_) async => Future.value());

    await deleteTodo.call(todoId);

    verify(mockTodoRepository.deleteTodoItem(todoId)).called(1);
  });
}
