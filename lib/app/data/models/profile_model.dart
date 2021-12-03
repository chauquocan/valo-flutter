import 'dart:convert';

import 'package:valo_chat_app/app/data/models/page_model.dart';

class UserPage {
  UserPage({
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

  List<UserContent> content;
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

  factory UserPage.fromRawJson(String str) =>
      UserPage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPage.fromJson(Map<String, dynamic> json) => UserPage(
        content: List<UserContent>.from(
            json["content"].map((x) => UserContent.fromJson(x))),
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

class UserContent {
  UserContent({
    required this.user,
    required this.friend,
  });

  User user;
  bool friend;

  factory UserContent.fromRawJson(String str) =>
      UserContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserContent.fromJson(Map<String, dynamic> json) => UserContent(
        user: User.fromJson(json["user"]),
        friend: json["friend"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "friend": friend,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.address,
    required this.imgUrl,
    required this.status,
  });

  String id;
  String name;
  String gender;
  DateTime dateOfBirth;
  String phone;
  String email;
  String address;
  String imgUrl;
  String status;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        gender: json["gender"] ?? "",
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        imgUrl: json["imgUrl"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "dateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "phone": phone,
        "email": email,
        "address": address,
        "imgUrl": imgUrl,
        "status": status,
      };
}
enum Gender {male, female}
