import 'dart:convert';

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
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  List<ContactContent> content;
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

  factory ContactPage.fromRawJson(String str) =>
      ContactPage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactPage.fromJson(Map<String, dynamic> json) => ContactPage(
        content:
            List<ContactContent>.from(json["content"].map((x) => ContactContent.fromJson(x))),
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

class ContactContent {
  ContactContent({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.addDateAt,
  });

  String id;
  String userId;
  String friendId;
  String addDateAt;

  factory ContactContent.fromRawJson(String str) => ContactContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactContent.fromJson(Map<String, dynamic> json) => ContactContent(
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
