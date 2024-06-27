class ProjectEntity{
   String id;
   String name;
   String description;
   String createdAt;
   String updatedAt;
  List<String> members;
  
  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });
  
    //move to a seperate file --> response
  factory ProjectEntity.fromJson(Map<String, dynamic> json) => ProjectEntity(
        id: json["id"] as String,
        name: json["name"]as String,
        description: json["description"]as String,
        createdAt: json["createdAt"]as String,
        updatedAt: json["updatedAt"]as String,
        members: json["members"] as List<String>,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "members": members,
    };
}