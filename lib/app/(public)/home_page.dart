import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../interactor/actions/theme_action.dart';
import '../interactor/actions/todo_action.dart';
import '../interactor/atoms/theme_atom.dart';
import '../interactor/atoms/todo_atom.dart';
import '../interactor/models/todo_model.dart';

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

  Future<Object?> editTodoDialog([TodoModel? model]) async {
    model ??= const TodoModel(id: -1, title: '', check: false);
    return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 700),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuart,
          ),
          child: AlertDialog(
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
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
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
            actions: [
              InkWell(
                onTap: () {
                  changeTheme();
                },
                child: themeAtom.value
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
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
