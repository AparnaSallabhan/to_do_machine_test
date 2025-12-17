import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    super.id,
    required super.userId,
    required super.projectName,
    required super.description,
    required super.startDate,
    required super.endDate,
    required super.isCompleted,
    required super.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      userId: json['user_id'],
      projectName: json['project_name'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      isCompleted: json['is_completed'],
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'project_name': projectName,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_completed': isCompleted,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
