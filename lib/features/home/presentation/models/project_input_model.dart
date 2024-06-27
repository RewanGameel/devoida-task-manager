import 'package:devoida_task_manager/app/extensions.dart';

class ProjectInputModel {
  final String name;
  final String id;
  final String description;
  final List<String> members;

  ProjectInputModel({required this.name, required this.id, required this.description, required this.members});

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "description": description,
    "createdAt": DateTime.now().toTimestamp(),
    "updatedAt": DateTime.now().toTimestamp(),
    "members": members,
  };
}