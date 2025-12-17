class Todo {
  final String? id;
  final String userId;
  final String projectName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;
  final DateTime updatedAt;

  Todo({
     this.id,
    required this.userId,
    required this.projectName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
    required this.updatedAt,
  });
}
