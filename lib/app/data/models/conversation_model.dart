import 'page_model.dart';

class ConversationCustom {
  String id;
  String name;
  String avatar;
  bool isGroup;
  String time;
  String currentMessage;
  String? status;
  bool select = false;
  String conversationType;
  ConversationCustom({
    required this.id,
    required this.name,
    required this.avatar,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    required this.conversationType,
    this.status,
    this.select = false,
  });
}

class ConversationPage {
  ConversationPage({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.sort,
    required this.first,
    required this.number,
    required this.numberOfElements,
    required this.size,
    required this.empty,
  });
  late final List<Conversation> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final Sort sort;
  late final bool first;
  late final int number;
  late final int numberOfElements;
  late final int size;
  late final bool empty;

  ConversationPage.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content'])
        .map((e) => Conversation.fromJson(e))
        .toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    number = json['number'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['number'] = number;
    _data['numberOfElements'] = numberOfElements;
    _data['size'] = size;
    _data['empty'] = empty;
    return _data;
  }
}

class Conversation {
  Conversation({
    required this.id,
    required this.createAt,
    required this.conversationType,
    required this.participants,
    required this.avatar,
    required this.isGroup,
    required this.lastMessage,
    required this.name,
    this.select,
    required this.time,
    this.status,
  });
  late final String id;
  late final String createAt;
  late final String conversationType;
  late final List<Participants> participants;

  late String name;
  late String avatar;
  late String lastMessage;
  late String time;
  late String? status;
  late bool? select = false;
  late bool isGroup;

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = json['createAt'];
    conversationType = json['conversationType'];
    participants = List.from(json['participants'])
        .map((e) => Participants.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['createAt'] = createAt;
    _data['conversationType'] = conversationType;
    _data['participants'] = participants.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Participants {
  Participants({
    required this.userId,
    required this.admin,
  });
  late final String userId;
  late final bool admin;

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['admin'] = admin;
    return _data;
  }
}
