import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/domain/entities/todo.dart';
import 'package:todo_flutter/domain/usecases/add_todo.dart';
import 'package:todo_flutter/domain/usecases/delete_todo.dart';
import 'package:todo_flutter/domain/usecases/fetch_todos.dart';
import 'package:todo_flutter/domain/usecases/toggle_todo_completion.dart';
import 'package:todo_flutter/presentation/cubits/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final AddTodo addTodo;
  final FetchTodos fetchTodos;
  final DeleteTodo deleteTodo;
  final ToggleTodoCompletion toggleTodoCompletion;

  TodoCubit({
    required this.addTodo,
    required this.fetchTodos,
    required this.deleteTodo,
    required this.toggleTodoCompletion,
  }) : super(TodoInitial());

  Future<void> loadTodos() async {
    emit(TodoLoading());
    try {
      final todos = await fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError("Failed to load todos"));
    }
  }

  Future<void> addTodoItem(String title) async {
    try {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
      );
      await addTodo.call(todo);
      loadTodos();
    } catch (e) {
      emit(TodoError("Failed to add todo"));
    }
  }

  Future<void> deleteTodoItem(String id) async {
    try {
      await deleteTodo.call(id);
      loadTodos();
    } catch (e) {
      emit(TodoError("Failed to delete todo"));
    }
  }

  Future<void> toggleCompletion(String id) async {
    try {
      await toggleTodoCompletion.call(id);
      loadTodos();
    } catch (e) {
      emit(TodoError("Failed to toggle todo"));
    }
  }
}
