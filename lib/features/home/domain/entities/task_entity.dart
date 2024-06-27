class TaskEntity{
  String id;
  String name;
  String description;
  String createdAt;
  String updatedAt;
  bool isDone;
  
  TaskEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
  });
    TaskEntity copyWith({
        String? name,
        String? id,
        String? description,
        String? createdAt,
        String? updatedAt,
        bool? isDone,
    }) => 
        TaskEntity(
            name: name ?? this.name,
            id: id ?? this.id,
            description: description ?? this.description,
            isDone: isDone ?? this.isDone,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
        );
  
  //move to a seperate file --> response
  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        id: json["id"] as String,
        name: json["name"]as String,
        description: json["description"]as String,
        createdAt: json["createdAt"]as String,
        updatedAt: json["updatedAt"]as String,
        isDone: json["isDone"] as bool,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDone": isDone,
    };
}