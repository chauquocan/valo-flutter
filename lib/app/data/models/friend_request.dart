import 'page_model.dart';

class FriendRequestPage {
  FriendRequestPage({
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
  late final List<FriendRequest> content;
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

  FriendRequestPage.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content'])
        .map((e) => FriendRequest.fromJson(e))
        .toList();
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

class FriendRequest {
  FriendRequest({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.sendAt,
  });
  late final String id;
  late final String fromId;
  late final String toId;
  late final String sendAt;

  FriendRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['fromId'];
    toId = json['toId'];
    sendAt = json['sendAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fromId'] = fromId;
    _data['toId'] = toId;
    _data['sendAt'] = sendAt;
    return _data;
  }
}


