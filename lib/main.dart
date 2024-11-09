import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/data/datasources/local_todo_datasource.dart';
import 'package:todo_flutter/data/repositories/todo_repository_impl.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/add_todo.dart';
import 'package:todo_flutter/domain/usecases/delete_todo.dart';
import 'package:todo_flutter/domain/usecases/fetch_todos.dart';
import 'package:todo_flutter/domain/usecases/toggle_todo_completion.dart';
import 'package:todo_flutter/presentation/cubits/todo_cubit.dart';
import 'package:todo_flutter/presentation/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TodoRepository>(
            create: (context) => TodoRepositoryImpl(LocalTodoDataSource()),
          )
        ],
        child: BlocProvider(
            create: (context) => TodoCubit(
                  addTodo: AddTodo(
                    RepositoryProvider.of<TodoRepository>(context),
                  ),
                  fetchTodos: FetchTodos(
                    RepositoryProvider.of<TodoRepository>(context),
                  ),
                  deleteTodo: DeleteTodo(
                    RepositoryProvider.of<TodoRepository>(context),
                  ),
                  toggleTodoCompletion: ToggleTodoCompletion(
                    RepositoryProvider.of<TodoRepository>(context),
                  ),
                ),
            child: TodoScreen()),
      ),
    );
  }
}