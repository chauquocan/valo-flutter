import 'dart:convert';

import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/page_model.dart';

class ConversationPage {
  ConversationPage({
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

  final List<ConversationContent> content;
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

  factory ConversationPage.fromRawJson(String str) =>
      ConversationPage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConversationPage.fromJson(Map<String, dynamic> json) =>
      ConversationPage(
        content: List<ConversationContent>.from(
            json["content"].map((x) => ConversationContent.fromJson(x))),
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

class ConversationContent {
  ConversationContent({
    required this.conversation,
    required this.lastMessage,
    required this.unReadMessage,
    this.isGroup =false,
  });

  final Conversation conversation;
  final LastMessage lastMessage;
  final int unReadMessage;
  final bool isGroup;

  factory ConversationContent.fromRawJson(String str) =>
      ConversationContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConversationContent.fromJson(Map<String, dynamic> json) =>
      ConversationContent(
        conversation: Conversation.fromJson(json["conversation"]),
        lastMessage: LastMessage.fromJson(json["lastMessage"]),
        unReadMessage: json["unReadMessage"],
      );

  Map<String, dynamic> toJson() => {
        "conversation": conversation.toJson(),
        "lastMessage": lastMessage.toJson(),
        "unReadMessage": unReadMessage,
      };
}

class Conversation {
  Conversation({
    required this.id,
    required this.createAt,
    required this.conversationType,
    required this.participants,
    required this.name,
    required this.createdByUserId,
    required this.imageUrl,
  });

  final String id;
  final String createAt;
  final String conversationType;
  final List<Participant> participants;
  final String name;
  final String createdByUserId;
  final String imageUrl;

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        createAt: json["createAt"],
        conversationType: json["conversationType"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
        name: json["name"] ??"",
        createdByUserId:
            json["createdByUserId"] ??"",
        imageUrl: json["imageUrl"] ??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createAt": createAt,
        "conversationType": conversationType,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "name": name == null ? null : name,
        "createdByUserId": createdByUserId == null ? null : createdByUserId,
        "imageUrl": imageUrl == null ? null : imageUrl,
      };
}

class Participant {
  Participant({
    required this.userId,
    required this.admin,
    required this.addByUserId,
    required this.addTime,
  });

  final String userId;
  final bool admin;
  final String addByUserId;
  final String addTime;

  factory Participant.fromRawJson(String str) =>
      Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        userId: json["userId"],
        admin: json["admin"],
        addByUserId: json["addByUserId"] ?? "",
        addTime: json["addTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "admin": admin,
        "addByUserId": addByUserId == null ? null : addByUserId,
        "addTime": addTime == null ? null : addTime,
      };
}

class LastMessage {
  LastMessage({
    required this.message,
    required this.userName,
    required this.userImgUrl,
  });

  final Message message;
  final String userName;
  final String userImgUrl;

  factory LastMessage.fromRawJson(String str) =>
      LastMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        message: Message.fromJson(json["message"]),
        userName: json["userName"] ??"",
        userImgUrl: json["userImgUrl"] ??"",
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "userName": userName == null ? null : userName,
        "userImgUrl": userImgUrl == null ? null : userImgUrl,
      };
}
