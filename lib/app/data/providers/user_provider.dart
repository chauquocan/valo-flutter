import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/register.dart';
import '../models/user.dart';

class UserProvider extends ConnectService {
  //end point
  static const String loginURL = 'auth/signin';
  static const String registerURL = 'auth/register';
  static const String userURL = 'users/';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //curent userId
  final _userId = Storage.getUser()?.id;

  //Đăng nhập
  Future<NetworkResponse<LoginRespone>> login(Map map) async {
    try {
      final response = await post(loginURL, data: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => LoginRespone.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Đăng ký
  Future<NetworkResponse<RegisterMessage>> register(Map map) async {
    try {
      final response = await post(registerURL, data: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => RegisterMessage.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get user bằng số điện thoại
  Future<NetworkResponse<ProfileResponse>> getUser(
      String numberPhone, String accessToken) async {
    try {
      final response = await get(userURL + numberPhone,
          options:
              Options(headers: {'Authorization': 'Bearer ${accessToken}'}));
      print(userURL + Storage.getToken()!.username);
      return NetworkResponse.fromResponse(
        response,
        (json) => ProfileResponse.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get tat ca user
  Future<List<ProfileResponse>> getAllUser(String accessToken) async {
    try {
      final response = await get(userURL,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      print(response.data);
      // return NetworkResponse.fromResponse(
      //   response,
      // (json) => ProfileResponse.fromJson(json),
      return (response.data as List)
          .map((x) => ProfileResponse.fromJson(x))
          .toList();
      // );
    } on DioError catch (e, s) {
      print(e.error);
      // return NetworkResponse.withError(e.response);
      throw Exception("$e///////////$s");
    }
  }

  //Update user info
  Future<NetworkResponse<ProfileResponse>> updateUserInfo(Map map) async {
    try {
      final response = await patch(
        userURL + _userId!,
        data: map,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer $_token'},
        ),
      );
      // (map) => ProfileResponse.fromJson(map);
      // return response.statusCode;
      print(response.statusCode);
      return NetworkResponse.fromResponse(
          response, (json) => ProfileResponse.fromJson(json));
    } on DioError catch (e) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Search
  Future<NetworkResponse<ProfileResponse>> searchUser(
      String numberPhone, String accessToken) async {
    try {
      final response = await get(userURL + numberPhone,
          options:
              Options(headers: {'Authorization': 'Bearer ${accessToken}'}));
      print(userURL + Storage.getToken()!.username);
      return NetworkResponse.fromResponse(
        response,
        (json) => ProfileResponse.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //upload hình
  Future<NetworkResponse<ProfileResponse>> uploadFile(filePath) async {
    try {
      FormData formData = FormData.fromMap(
          {"image": await MultipartFile.fromFile(filePath, filename: "dp")});
      Response response = await patch(
        userURL + _userId!,
        data: formData,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ProfileResponse.fromJson(json),
      );
    } on DioError catch (e) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }
}
