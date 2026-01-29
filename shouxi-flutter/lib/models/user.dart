class User {
  String id;
  String email;
  String name;
  String createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'created_at': createdAt,
  };
}
