import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoStatus {
final TodoRepository todoRepository;
  UpdateTodoStatus(this.todoRepository);

  Future<Either<Failure, void>> call({
    required String todoId,
    required bool isCompleted,
  }) {
    return todoRepository.updateTodoStatus(
      todoId: todoId,
      isCompleted: isCompleted,
    );
  }
}
