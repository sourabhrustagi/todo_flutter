import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/presentation/cubits/todo_cubit.dart';
import 'package:todo_flutter/presentation/cubits/todo_state.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do App')),
      body: BlocConsumer<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<TodoCubit>(context)
                                .toggleCompletion(todo.id);
                          },
                          icon: Icon(
                            todo.isCompleted
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                        ),
                        onLongPress: () {
                          BlocProvider.of<TodoCubit>(context)
                              .deleteTodoItem(todo.id);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _todoController,
                        decoration:
                            const InputDecoration(labelText: 'Add Todo'),
                      )),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<TodoCubit>(context)
                              .addTodoItem(_todoController.text);
                          _todoController.clear();
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("No todos found"));
        },
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}
