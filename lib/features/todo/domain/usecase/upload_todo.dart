import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';
import 'package:to_do_machine_test/features/todo/domain/repositories/todo_repository.dart';

class UploadTodo {
  final TodoRepository todoRepository;
  UploadTodo(this.todoRepository);

  Future<Either<Failure, Todo>> call(TodoParams params) async {
    return await todoRepository.uploadTodo(
      userId: params.userId,
      projectName: params.projectName,
      description: params.description,
      startDate: params.startDate,
      endDate: params.endDate,
      isCompleted: params.isCompleted,
    );
  }
}

class TodoParams {
  final String userId;
  final String projectName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;

  TodoParams({
    required this.userId,
    required this.projectName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
  });
}
