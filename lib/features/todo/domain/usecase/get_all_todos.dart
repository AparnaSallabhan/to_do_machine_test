import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';
import 'package:to_do_machine_test/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodos {
  final TodoRepository todoRepository;

  GetAllTodos(this.todoRepository);
  Future<Either<Failure, List<Todo>>> call() async {
    return await todoRepository.getAllTodos();
  }
}
