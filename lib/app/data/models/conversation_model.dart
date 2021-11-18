import './message_model.dart';
import 'page_model.dart';

class ConversationPage {
  ConversationPage({
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

  final List<Content> content;
  final Pageable pageable;
  final bool last;
  final int totalElements;
  final int totalPages;
  final int size;
  final int number;
  final Sort sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  factory ConversationPage.fromJson(Map<String, dynamic> json) =>
      ConversationPage(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
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

class Content {
  Content({
    required this.conversation,
    required this.message,
    required this.unReadMessage,
  });

  final Conversation conversation;
  final Message message;
  final int unReadMessage;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        conversation: Conversation.fromJson(json["conversation"]),
        message: Message.fromJson(json["message"]),
        unReadMessage: json["unReadMessage"],
      );

  Map<String, dynamic> toJson() => {
        "conversation": conversation.toJson(),
        "message": message.toJson(),
        "unReadMessage": unReadMessage,
      };
}

class Conversation {
  Conversation({
    required this.id,
    required this.createAt,
    required this.conversationType,
    required this.participants,
    required this.imageUrl,
    required this.isGroup,
    required this.lastMessage,
    required this.name,
    this.select,
    this.unread =0,
    required this.time,
    this.status,
  });
  late final String id;
  late String name;
  late final String createAt;
  late final String conversationType;
  late final List<Participants> participants;
  late String createdByUserId;
  late String imageUrl;
  //custom
  late String lastMessage;
  late String time;
  late String? status;
  late int unread;
  late bool? select = false;
  late bool isGroup;

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    createAt = json['createAt'];
    conversationType = json['conversationType'];
    participants = List.from(json['participants'])
        .map((e) => Participants.fromJson(e))
        .toList();
    createdByUserId = json['createdByUserId'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['createAt'] = createAt;
    _data['conversationType'] = conversationType;
    _data['participants'] = participants.map((e) => e.toJson()).toList();
    _data['createdByUserId'] = createdByUserId;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}

class Participants {
  Participants({
    required this.userId,
    required this.addByUserId,
    required this.addTime,
    required this.admin,
  });
  late final String userId;
  late final String addByUserId;
  late final String addTime;
  late final bool admin;

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    addByUserId = json['addByUserId'] ?? "";
    addTime = json['addTime'] ?? "";
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['addByUserId'] = addByUserId;
    _data['addTime'] = addTime;
    _data['admin'] = admin;
    return _data;
  }
}
