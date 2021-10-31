import 'dart:convert';

import 'user.dart';
//Register response mess
class RegisterMessage {
  RegisterMessage({
    // required this.code,
    required this.message,
    // this.data,
  });

  // final int code;
  final String message;
  // final User? data;

  factory RegisterMessage.fromRawJson(String str) =>
      RegisterMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterMessage.fromJson(Map<String, dynamic> json) => RegisterMessage(
        // code: json["code"],
        message: json["message"],
        // data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        // "code": code,
        "message": message,
        // "data": data?.toJson(),
      };
}
