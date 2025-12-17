part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class TodoUploadEvent extends TodoEvent {
  final String userId;
  final String projectName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;

  TodoUploadEvent({
    required this.userId,
    required this.projectName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
  });
}

final class TodoGetAllTodoEvent extends TodoEvent {}

class TodoMarkCompletedEvent extends TodoEvent {
  final String todoId;
  final bool isCompleted;

  TodoMarkCompletedEvent({required this.todoId, required this.isCompleted});
}
