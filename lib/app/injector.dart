import 'package:app_mini_core/app/data/repositories/shared_todo_repository.dart';
import 'package:app_mini_core/app/interactor/repositories/todo_repository.dart';
import 'package:auto_injector/auto_injector.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<TodoRepository>(SharedTodoRepository.new);
}
