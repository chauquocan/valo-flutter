import 'dart:convert';

import 'package:valo_chat_app/app/data/models/page_model.dart';

class MessagePage {
  MessagePage({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  final List<MessageContent> content;
  final Pageable pageable;
  final bool last;
  final int totalPages;
  final int totalElements;
  final int size;
  final int number;
  final Sort sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  factory MessagePage.fromRawJson(String str) =>
      MessagePage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessagePage.fromJson(Map<String, dynamic> json) => MessagePage(
        content: List<MessageContent>.from(
            json["content"].map((x) => MessageContent.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}

class MessageContent {
  MessageContent({
    required this.message,
    required this.userName,
    required this.userImgUrl,
    this.select,
    this.status,
  });

  Message message;
  String userName;
  String userImgUrl;
  String? status;
  bool? select = false;

  factory MessageContent.fromRawJson(String str) =>
      MessageContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageContent.fromJson(Map<String, dynamic> json) => MessageContent(
        message: Message.fromJson(json["message"]),
        userName: json["userName"] ?? "",
        userImgUrl: json["userImgUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "userName": userName == null ? null : userName,
        "userImgUrl": userImgUrl == null ? null : userImgUrl,
      };
}

class Message {
  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.sendAt,
    required this.messageType,
    required this.content,
    required this.messageStatus,
    required this.replyId,
    required this.reactions,
    required this.pin,
  });

  String id;
  String conversationId;
  String senderId;
  DateTime sendAt;
  String messageType;
  String content;
  String messageStatus;
  String replyId;
  List<Reaction>? reactions;
  bool pin;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] ?? "",
        conversationId: json["conversationId"] ?? "",
        senderId: json["senderId"] ?? "",
        sendAt: DateTime.parse(json["sendAt"]),
        messageType: json["messageType"] ?? "",
        content: json["content"] ?? "",
        messageStatus: json["messageStatus"] ?? "",
        replyId: json["replyId"] ?? "",
        reactions: json["reactions"] == null
            ? []
            : List<Reaction>.from(
                json["reactions"].map((x) => Reaction.fromJson(x))),
        pin: json["pin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversationId": conversationId,
        "senderId": senderId == null ? null : senderId,
        "sendAt": sendAt.toIso8601String(),
        "messageType": messageType,
        "content": content,
        "messageStatus": messageStatus == null ? null : messageStatus,
        "replyId": replyId == null ? null : replyId,
        "reactions": reactions == null
            ? null
            : List<dynamic>.from(reactions!.map((x) => x.toJson())),
        "pin": pin,
      };
}

class Reaction {
  Reaction({
    required this.userId,
    required this.reactionType,
  });

  String userId;
  String reactionType;

  factory Reaction.fromRawJson(String str) =>
      Reaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        userId: json["userId"],
        reactionType: json["reactionType"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "reactionType": reactionType,
      };
}

List<String> fileModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String fileModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
