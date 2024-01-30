import 'package:app_mini_core/app/injector.dart';
import 'package:app_mini_core/app/interactor/atoms/todo_atom.dart';
import 'package:app_mini_core/app/interactor/models/todo_model.dart';
import 'package:app_mini_core/app/interactor/repositories/todo_repository.dart';

Future<void> fetchTodos() async {
  final repository = injector.get<TodoRepository>();

  todoState.value = await repository.getAll();
}

Future<void> putTodo(TodoModel model) async {
  final repository = injector.get<TodoRepository>();

  if (model.id == -1) {
    await repository.insert(model);
  } else {
    await repository.update(model);
  }

  fetchTodos();
}

Future<void> deleteTodo(int id) async {
  final repository = injector.get<TodoRepository>();
  await repository.delete(id);
  fetchTodos();
}
