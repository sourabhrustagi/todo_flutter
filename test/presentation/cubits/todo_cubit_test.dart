import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/usecases/add_todo.dart';
import 'package:todo_flutter/domain/usecases/delete_todo.dart';
import 'package:todo_flutter/domain/usecases/fetch_todos.dart';
import 'package:todo_flutter/domain/usecases/toggle_todo_completion.dart';
import 'package:todo_flutter/presentation/cubits/todo_cubit.dart';
import 'package:todo_flutter/presentation/cubits/todo_state.dart';

import 'todo_cubit_test.mocks.dart';

@GenerateMocks([AddTodo, FetchTodos, DeleteTodo, ToggleTodoCompletion])
void main() {
  late TodoCubit todoCubit;
  late MockAddTodo mockAddTodo;
  late MockFetchTodos mockFetchTodos;
  late MockDeleteTodo mockDeleteTodo;
  late MockToggleTodoCompletion mockToggleTodoCompletion;

  setUp(() {
    mockAddTodo = MockAddTodo();
    mockFetchTodos = MockFetchTodos();
    mockDeleteTodo = MockDeleteTodo();
    mockToggleTodoCompletion = MockToggleTodoCompletion();
    todoCubit = TodoCubit(
      addTodo: mockAddTodo,
      fetchTodos: mockFetchTodos,
      deleteTodo: mockDeleteTodo,
      toggleTodoCompletion: mockToggleTodoCompletion,
    );
  });
  tearDown(() {
    todoCubit.close();
  });

  group('loadTodos', () {
    blocTest<TodoCubit, TodoState>(
      'emits [TodoLoading, TodoLoaded] when data is fetched successfully',
      build: () {
        final todos = [
          const Todo(
            id: '1',
            title: 'Test Todo 1',
            isCompleted: false,
          )
        ];
        when(mockFetchTodos()).thenAnswer((_) async => todos);
        return todoCubit;
      },
      act: (cubit) => cubit.loadTodos(),
      expect: () => [
        TodoLoading(),
        TodoLoaded(
          const [Todo(id: '1', title: 'Test Todo 1', isCompleted: false)],
        )
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits [TodoLoading, TodoError] when fetching data fails',
      build: () {
        when(mockFetchTodos()).thenThrow(Exception('Failed to load todos'));
        return todoCubit;
      },
      act: (cubit) => cubit.loadTodos(),
      expect: () => [TodoLoading(), TodoError('Failed to load todos')],
    );
  });

  group('addTodoItem', () {
    blocTest<TodoCubit, TodoState>(
      'calls addTodo use case and loadTodos',
      build: () {
        when(mockAddTodo.call(any)).thenAnswer((_) async => {});
        when(mockFetchTodos()).thenAnswer((_) async => []);
        return todoCubit;
      },
      act: (cubit) => cubit.addTodoItem('New Todo'),
      expect: () => [
        TodoLoading(),
        TodoLoaded(const []),
      ],
    );

    blocTest<TodoCubit, TodoState>(
      'emits TodoError when adding todo fails',
      build: () {
        when(mockAddTodo.call(any)).thenThrow(Exception('Failed to add todo'));
        return todoCubit;
      },
      act: (cubit) => cubit.addTodoItem('New Todo'),
      expect: () => [
        TodoError('Failed to add todo'),
      ],
    );
  });

}
