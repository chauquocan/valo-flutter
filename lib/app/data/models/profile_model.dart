import 'dart:convert';

import 'package:valo_chat_app/app/data/models/page_model.dart';


class ProfilePage {
  ProfilePage({
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
  late final List<Profile> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalElements;
  late final int totalPages;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;
  
  ProfilePage.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Profile.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Profile {
  Profile({
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
  late final String id;
  late final String name;
  late final String gender;
  late final String dateOfBirth;
  late final String phone;
  late final String email;
  late final String address;
  late final String imgUrl;
  late final String status;

  factory Profile.fromRawJson(String str) =>
      Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  
  Profile.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    imgUrl = json['imgUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['gender'] = gender;
    _data['dateOfBirth'] = dateOfBirth;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['address'] = address;
    _data['imgUrl'] = imgUrl;
    _data['status'] = status;
    return _data;
  }
}
