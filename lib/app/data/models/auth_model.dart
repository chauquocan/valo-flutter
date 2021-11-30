import 'dart:convert';

//Auth response
class LoginRespone {
  LoginRespone({
    // required this.id,
    required this.username,
    // required this.password,
    required this.accessToken,
    required this.refreshToken,
  });

  // final int id;
  final String username;
  // final String password;
  final String accessToken;
  final String refreshToken;

  factory LoginRespone.fromRawJson(String str) =>
      LoginRespone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRespone.fromJson(Map<String, dynamic> json) => LoginRespone(
        // id: json["id"],
        username: json["username"] ?? "",
        // password: json["password"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "username": username,
        // "password": password,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class RefreshTokenResponse {
  RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory RefreshTokenResponse.fromRawJson(String str) =>
      RefreshTokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
