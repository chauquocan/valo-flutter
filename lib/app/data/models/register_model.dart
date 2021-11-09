import 'dart:convert';

import 'user_model.dart';

//Register response mess
class ResponseMessage {
  ResponseMessage({
    required this.message,
  });

  final String message;

  factory ResponseMessage.fromRawJson(String str) =>
      ResponseMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      ResponseMessage(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
