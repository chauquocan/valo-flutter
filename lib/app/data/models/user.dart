import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.accessToken,
  });

  final int id;
  final String username;
  final String password;
  final String accessToken;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "accessToken": accessToken,
      };
}
