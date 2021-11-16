import 'dart:convert';

import 'package:valo_chat_app/app/data/models/page_model.dart';

// class MessageModel {
//   final String? id;
//   final String type;
//   final String message;
//   final int time;

//   MessageModel({
//     this.id,
//     required this.message,
//     required this.type,
//     required this.time,
//   });
// }

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
    this.id,
    required this.conversationId,
    this.sendAt,
    required this.messageType,
    this.senderId,
    required this.content,
    this.replyId,
  });
  late final String? id;
  late final String conversationId;
  late final String? sendAt;
  late final String? senderId;
  late final String messageType;
  late final String content;
  late final String? replyId;

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversationId'];
    sendAt = json['sendAt'];
    messageType = json['messageType'];
    content = json['content'];
    senderId = json['senderId'];
    replyId = json['replyId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['conversationId'] = conversationId;
    _data['sendAt'] = sendAt;
    _data['messageType'] = messageType;
    _data['content'] = content;
    _data['senderId'] = senderId;
    _data['replyId'] = replyId;

    return _data;
  }
}

class MessageDTO {
  late final String conversationId;
  late final String? senderId;
  late final String messageType;
  late final String content;
  late final String? replyId;

  MessageDTO({
    required this.conversationId,
    required this.messageType,
    this.senderId,
    required this.content,
    this.replyId,
  });

  MessageDTO.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    messageType = json['messageType'];
    content = json['content'];
    senderId = json['senderId'];
    replyId = json['replyId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['conversationId'] = conversationId;
    _data['messageType'] = messageType;
    _data['content'] = content;
    _data['senderId'] = senderId;
    _data['replyId'] = replyId;
    return _data;
  }
}
