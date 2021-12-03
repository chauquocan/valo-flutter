// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/profile_model.dart';

class ProfileProvider {
  static const String userURL = 'users';
  static const String searchURL = '$userURL/search';
  static const String userPhoneURL = '$userURL/phone=';
  static const String updateURL = '$userURL/update';
  static const String changImageURL = '$userURL/me/changeImage';

  //Get user bằng số id
  Future<NetworkResponse<User>> getUserById(String id) async {
    try {
      final response = await ConnectService().get('$userURL/$id',
          options: Options(headers: {
            'Authorization':
                'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
          }));
      return NetworkResponse.fromResponse(
        response,
        (json) => User.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Get user bằng số điện thoại
  Future<NetworkResponse<User>> getUserByPhone(
      String numberPhone, String accessToken) async {
    try {
      final response = await ConnectService().get(
          '${userPhoneURL}${numberPhone}',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      return NetworkResponse.fromResponse(
        response,
        (json) => User.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Update user info
  Future<NetworkResponse<User>> updateUserInfo(Map map) async {
    try {
      final response = await ConnectService().patch(
        updateURL,
        params: map,
        options: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
          },
        ),
      );
      
      return NetworkResponse.fromResponse(
          response, (json) => User.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Search user
  Future<NetworkResponse<UserPage>> searchUser(String textToSearch) async {
    try {
      final response = await ConnectService().get(searchURL,
          params: {
            'textToSearch': textToSearch,
          },
          options: Options(headers: {
            'Authorization':
                'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
          }));
      return NetworkResponse.fromResponse(
        response,
        (json) => UserPage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //upload hình
  Future<NetworkResponse<User>> uploadFile(filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "multipartFile": await MultipartFile.fromFile(filePath, filename: 'avt')
      });
      Response response = await ConnectService().put(
        changImageURL,
        params: formData,
        options: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer ${LocalStorage.getToken()?.accessToken.toString()}',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => User.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }
}
