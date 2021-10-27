import 'dart:convert';

class LoginRespone {
  LoginRespone({
    // required this.id,
    required this.username,
    // required this.password,
    required this.accessToken,
  });

  // final int id;
  final String username;
  // final String password;
  final String accessToken;

  factory LoginRespone.fromRawJson(String str) =>
      LoginRespone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRespone.fromJson(Map<String, dynamic> json) => LoginRespone(
        // id: json["id"],
        username: json["username"],
        // password: json["password"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "username": username,
        // "password": password,
        "accessToken": accessToken,
      };
}

class UserResponse {
  String id;
  String name;
  String gender;
  String dateOfBirth;
  String phone;
  String email;
  String address;
  String imgUrl;
  String status;

  UserResponse({
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
  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        dateOfBirth: json['dateOfBirth'],
        phone: json['phone'],
        email: json['email'],
        address: json['address'],
        imgUrl: json['imgUrl'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['imgUrl'] = imgUrl;
    data['status'] = status;
    return data;
  }
}
