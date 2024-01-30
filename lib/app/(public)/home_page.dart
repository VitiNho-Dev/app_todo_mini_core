import 'package:app_mini_core/app/interactor/actions/todo_action.dart';
import 'package:app_mini_core/app/interactor/atoms/todo_atom.dart';
import 'package:app_mini_core/app/interactor/models/todo_model.dart';
import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void editTodoDialog([TodoModel? model]) {
    model ??= TodoModel(id: -1, title: '', check: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit todo'),
          content: TextFormField(
            initialValue: model?.title,
            onChanged: (value) {
              model = model!.copyWith(title: value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                deleteTodo(model!.id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                putTodo(model!);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        final todos = todoState.value;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home page'),
          ),
          body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return GestureDetector(
                onLongPress: () {
                  editTodoDialog(todo);
                },
                child: CheckboxListTile(
                  value: todo.check,
                  title: Text(todo.title),
                  onChanged: (value) {
                    putTodo(todo.copyWith(check: value));
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editTodoDialog,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
