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
  late final List<Message> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;

  MessagePage.fromJson(Map<String, dynamic> json) {
    content =
        List.from(json['content']).map((e) => Message.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Message {
  Message({
    required this.id,
    required this.conversationId,
    required this.sendAt,
    required this.messageType,
    required this.content,
    required this.senderId,
    required this.replyId,
  });

  final String id;
  final String conversationId;
  final DateTime sendAt;
  final String messageType;
  final String content;
  final String senderId;
  final String replyId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? "" : json["id"],
        conversationId: json["conversationId"],
        sendAt: DateTime.parse(json["sendAt"]),
        messageType: json["messageType"],
        content: json["content"],
        senderId: json["senderId"] == null ? "" : json["senderId"],
        replyId: json["replyId"] == null ? "" : json["replyId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversationId": conversationId,
        "sendAt": sendAt.toIso8601String(),
        "messageType": messageType,
        "content": content,
        "senderId": senderId == null ? "" : senderId,
        "replyId": replyId == null ? "" : replyId,
      };
}
