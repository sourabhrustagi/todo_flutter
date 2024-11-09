import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/toggle_todo_completion.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late ToggleTodoCompletion toggleTodoCompletion;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    toggleTodoCompletion = ToggleTodoCompletion(mockTodoRepository);
  });

  test('should call toggleTodoItemCompletion on the repository', () async {
    const todoId = '1';

    when(mockTodoRepository.toggleTodoItemCompletion(todoId))
        .thenAnswer((_) async => Future.value());

    await toggleTodoCompletion.call(todoId);

    verify(mockTodoRepository.toggleTodoItemCompletion(todoId)).called(1);
  });
}
