class User {
  final int id;
  final String name;
  final String email;
  final String avatar;

  User({required this.id, required this.name, required this.email, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['first_name'] + " " + json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
