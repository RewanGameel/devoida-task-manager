import 'package:devoida_task_manager/app/extensions.dart';

class TaskInputModel {
  final String name;
  final String description;
  final String deadlineDate;
  final String projectId;
  final String assignee; 

  TaskInputModel({
    required this.name,
    required this.description,
    required this.projectId,
    required this.assignee,
    required this.deadlineDate,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'projectId': projectId,
      'assignee': assignee,
      'isDone': false,
      'deadlineDate': DateTime.parse(deadlineDate).toTimestamp(),
      'createdAt': DateTime.now().toTimestamp(),
      'updatedAt': DateTime.now().toTimestamp(),
    };
  }
}