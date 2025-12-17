import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:to_do_machine_test/features/todo/data/models/todo_model.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';
import 'package:to_do_machine_test/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource todoRemoteDataSource;

  TodoRepositoryImpl(this.todoRemoteDataSource);

  @override
  Future<Either<Failure, Todo>> uploadTodo({
    required String userId,
    required String projectName,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isCompleted,
  }) async {
    try {
      TodoModel todo = TodoModel(
        userId: userId,
        projectName: projectName,
        description: description,
        startDate: startDate,
        endDate: endDate,
        isCompleted: isCompleted,
        updatedAt: DateTime.now(),
      );

      await todoRemoteDataSource.uploadTodo(todo);

      return right(todo);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getAllTodos() async {
    try {
      final todos = await todoRemoteDataSource.getAllTodos();

      return right(todos);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Either<Failure, void>> updateTodoStatus({required String todoId, required bool isCompleted})async {
    try {
    await todoRemoteDataSource.updateTodoStatus(
      todoId: todoId,
      isCompleted: isCompleted,
    );
    return right(null);
  } catch (e) {
    return left(Failure(e.toString()));
  }
  }
}
