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

  List<ConversationContent> content;
  Pageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

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
    this.isGroup = false,
    this.status ='offline',
  });

  Conversation conversation;
  LastMessage lastMessage;
  int unReadMessage;
  bool isGroup;
  String status;

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

  String id;
  String createAt;
  String conversationType;
  List<Participant> participants;
  String name;
  String createdByUserId;
  String imageUrl;

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        createAt: json["createAt"],
        conversationType: json["conversationType"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
        name: json["name"] ?? "",
        createdByUserId: json["createdByUserId"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
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

List<Participant> participantsFromJson(String str) =>
    List<Participant>.from(jsonDecode(str).map((x) => Participant.fromJson(x)));

class Participant {
  Participant({
    required this.userId,
    required this.admin,
    required this.addByUserId,
    required this.addTime,
  });

  String userId;
  bool admin;
  String addByUserId;
  String addTime;

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

  Message message;
  String userName;
  String userImgUrl;

  factory LastMessage.fromRawJson(String str) =>
      LastMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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

class ListFriendsCanAdd {
  ListFriendsCanAdd({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.sort,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.empty,
  });

  List<FriendsCanAdd> content;
  Pageable pageable;
  bool last;
  int totalElements;
  int totalPages;
  bool first;
  Sort sort;
  int size;
  int number;
  int numberOfElements;
  bool empty;

  factory ListFriendsCanAdd.fromRawJson(String str) =>
      ListFriendsCanAdd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListFriendsCanAdd.fromJson(Map<String, dynamic> json) =>
      ListFriendsCanAdd(
        content: List<FriendsCanAdd>.from(
            json["content"].map((x) => FriendsCanAdd.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        first: json["first"],
        sort: Sort.fromJson(json["sort"]),
        size: json["size"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "first": first,
        "sort": sort.toJson(),
        "size": size,
        "number": number,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}

class FriendsCanAdd {
  FriendsCanAdd({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.addDateAt,
  });

  String id;
  String userId;
  String friendId;
  String addDateAt;

  factory FriendsCanAdd.fromRawJson(String str) =>
      FriendsCanAdd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendsCanAdd.fromJson(Map<String, dynamic> json) => FriendsCanAdd(
        id: json["id"],
        userId: json["userId"],
        friendId: json["friendId"],
        addDateAt: json["addDateAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "friendId": friendId,
        "addDateAt": addDateAt,
      };
}

class ListParticipant {
  ListParticipant({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  List<Participant> content;
  Pageable pageable;
  bool last;
  int totalElements;
  int totalPages;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  factory ListParticipant.fromRawJson(String str) =>
      ListParticipant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListParticipant.fromJson(Map<String, dynamic> json) =>
      ListParticipant(
        content: List<Participant>.from(
            json["content"].map((x) => Participant.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
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
        "totalElements": totalElements,
        "totalPages": totalPages,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}
