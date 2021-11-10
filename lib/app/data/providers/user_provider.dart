import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/response_message_model.dart';
import '../models/user_model.dart';

class UserProvider extends ConnectService {
  //end point
  static const String loginURL = 'auth/signin';
  static const String registerURL = 'auth/register';
  static const String userURL = 'users/';
  static const String refreshTokenUrl = 'auth/refresh_token';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //current rfToken
  final _refreshToken = Storage.getToken()?.refreshToken;
  //curent userId
  final _userId = Storage.getUser()?.id;

  // Refresh token
  Future<NetworkResponse<LoginRespone>> refreshToken(Map refreshToken) async {
    try {
      final response = await post(refreshTokenUrl, data: refreshToken);
      return NetworkResponse.fromResponse(
        response,
        (json) => LoginRespone.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

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
  Future<NetworkResponse<ResponseMessage>> register(Map map) async {
    try {
      final response = await post(registerURL, data: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get user bằng số id
  Future<NetworkResponse<ProfileResponse>> getUserById(
      String id) async {
    try {
      final response = await get('${userURL}${id}',
          options:
              Options(headers: {'Authorization': 'Bearer ${Storage.getToken()?.accessToken}'}));
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

  //Get user bằng số điện thoại
  Future<NetworkResponse<ProfileResponse>> getUserByPhone(
      String numberPhone, String accessToken) async {
    try {
      final response = await get('${userURL}phone=${numberPhone}',
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



  //Update user info
  Future<NetworkResponse<ProfileResponse>> updateUserInfo(Map map) async {
    try {
      final response = await patch(
        '${userURL}/update',
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
      final response = await get('${userURL}phone=${numberPhone}',
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
      FormData formData = FormData.fromMap({
        "multipartFile": await MultipartFile.fromFile(filePath, filename: 'avt')
      });
      Response response = await put(
        userURL + '/me/changeImage',
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
