import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> uploadTodo({
    required String userId,
    required String projectName,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isCompleted,
  });

  Future<Either<Failure, List<Todo>>> getAllTodos();

  Future<Either<Failure, void>> updateTodoStatus({
    required String todoId,
    required bool isCompleted,
  });
}
