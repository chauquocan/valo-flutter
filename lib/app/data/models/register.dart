import 'dart:convert';

import 'user.dart';

class Register {
  Register({
    required this.code,
    required this.message,
    this.data,
  });

  final int code;
  final String message;
  final User? data;

  factory Register.fromRawJson(String str) =>
      Register.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        code: json["code"],
        message: json["message"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}
