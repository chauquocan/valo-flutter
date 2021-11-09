import 'dart:convert';

class ContactModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? id;
  String? icon;
  ContactModel(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.id,
      this.icon = "assets/icons/User Icon.svg"});
}

class FriendPage {
  FriendPage({
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
  late final List<FriendContent> content;
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

  FriendPage.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content'])
        .map((e) => FriendContent.fromJson(e))
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

class FriendContent {
  FriendContent({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.sendAt,
  });
  late final String id;
  late final String fromId;
  late final String toId;
  late final String sendAt;

  FriendContent.fromJson(Map<String, dynamic> json) {
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

class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageNumber;
  late final int pageSize;
  late final bool paged;
  late final bool unpaged;

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageNumber'] = pageNumber;
    _data['pageSize'] = pageSize;
    _data['paged'] = paged;
    _data['unpaged'] = unpaged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}

class FriendModel {
  FriendModel({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.addDateAt,
  });
  late final String id;
  late final String userId;
  late final String friendId;
  late final String addDateAt;

  FriendModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    friendId = json['friendId'];
    addDateAt = json['addDateAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['friendId'] = friendId;
    _data['addDateAt'] = addDateAt;
    return _data;
  }
}
