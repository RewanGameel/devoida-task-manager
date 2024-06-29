class TaskEntity{
  String id;
  String name;
  String deadlineDate;
  String description;
  String createdAt;
  String updatedAt;
  bool isDone;
  String assignee;
  
  TaskEntity({
    required this.id,
    required this.name,
    required this.deadlineDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
    required this.assignee,
  });
    TaskEntity copyWith({
        String? name,
        String? id,
        String? deadlineDate,
        String? description,
        String? createdAt,
        String? updatedAt,
        bool? isDone,
        String? assignee,
    }) => 
        TaskEntity(
            name: name ?? this.name,
            id: id ?? this.id,
            deadlineDate: deadlineDate ?? this.deadlineDate,
            description: description ?? this.description,
            isDone: isDone ?? this.isDone,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            assignee: assignee ?? this.assignee,
        );
  
  //move to a seperate file --> response
  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        id: json["id"] as String,
        name: json["name"]as String,
        description: json["description"]as String,
        createdAt: json["createdAt"]as String,
        deadlineDate: json["deadlineDate"]as String,
        updatedAt: json["updatedAt"]as String,
        isDone: json["isDone"] as bool,
        assignee: json["assignee"] as String,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDone": isDone,
        "deadlineDate": deadlineDate,
        "assignee": assignee,
    };
}