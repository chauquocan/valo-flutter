import 'page_model.dart';

class ContactCustom {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? id;
  String? imgUrl;
  String? icon;
  ContactCustom({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.id,
    this.imgUrl,
    this.icon,
  });
}

class ContactPage {
  ContactPage({
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
  late final List<ContactContent> content;
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

  ContactPage.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content'])
        .map((e) => ContactContent.fromJson(e))
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

class ContactContent {
  ContactContent({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.addDateAt,
  });
  late final String id;
  late final String userId;
  late final String friendId;
  late final String addDateAt;

  ContactContent.fromJson(Map<String, dynamic> json) {
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
