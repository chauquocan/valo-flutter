import 'dart:convert';

class User {
  User({
    required this.id,
    required this.username,
    // required this.email,
    required this.password,
    // required this.phone,
    required this.accessToken,
  });

  final int id;
  final String username;
  // final String email;
  final String password;
  // final String phone;
  final String accessToken;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        // email: json["email"],
        password: json["password"],
        // phone: json["phone"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        // "email": email,
        "password": password,
        // "phone": phone,
        "accessToken": accessToken,
      };
}
