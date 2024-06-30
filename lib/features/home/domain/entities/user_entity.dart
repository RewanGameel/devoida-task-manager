class UserEntity{
  String id;
  String name;
  String createdAt;
  String email;
  
  UserEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.email,
  });
    UserEntity copyWith({
        String? name,
        String? id,
        String? createdAt,
        String? email,
    }) => 
        UserEntity(
            name: name ?? this.name,
            id: id ?? this.id,
          createdAt: createdAt ?? this.createdAt,
            email: email ?? this.email,
        );
  
  //move to a seperate file --> response
  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] as String,
        name: json["name"]as String,
        createdAt: json["createdAt"]as String,
        email: json["email"] as String,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt,
        "email": email,
    };
}