import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/auth_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/response_model.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AuthProvider extends ConnectService {
  //end point
  static const String checkURL = 'auth/check/';
  static const String loginURL = 'auth/signin';
  static const String registerURL = 'auth/register';
  static const String logoutURL = 'auth/signout';
  static const String refreshTokenUrl = 'auth/refresh_token';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //current rfToken
  final _refreshToken = Storage.getToken()?.refreshToken;
  //curent userId
  final _userId = Storage.getUser()?.id;

  //Check phone number exist
  Future<NetworkResponse<ResponseMessage>> checkPhoneExist(
      String phoneNumber) async {
    try {
      final response = await get(checkURL + phoneNumber);
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e) {
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
      return NetworkResponse.withError(e.response);
    }
  }

  // Refresh token
  Future<NetworkResponse<LoginRespone>> refreshToken() async {
    final map = {'refreshToken': _refreshToken};
    try {
      final response = await post(refreshTokenUrl, data: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => LoginRespone.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<ResponseMessage>> logout() async {
    Map map = {'refreshToken': _refreshToken};
    try {
      final response = await post(logoutURL, data: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }
}
