import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/auth_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/response_model.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class AuthProvider {
  //end point
  static const String checkURL = 'auth/check';
  static const String loginURL = 'auth/signin';
  static const String resetPasswordURL = 'auth/changePassword';
  static const String registerURL = 'auth/register';
  static const String logoutURL = 'auth/signout';
  static const String refreshTokenUrl = 'auth/refresh_token';

  //Check phone number exist
  Future<Response> checkPhoneExist(
      String phoneNumber) async {
    try {
      final response = await ConnectService().get('$checkURL/$phoneNumber');
      return response;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  //Đăng nhập
  Future<NetworkResponse<LoginRespone>> login(Map map) async {
    try {
      final response = await ConnectService().postAuth(loginURL, params: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => LoginRespone.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Đăng ký
  Future<NetworkResponse<ResponseMessage>> register(Map map) async {
    try {
      final response =
          await ConnectService().postAuth(registerURL, params: map);
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  // Refresh token
  Future<NetworkResponse<LoginRespone>> refreshToken() async {
    final map = {
      'refreshToken': LocalStorage.getToken()?.refreshToken.toString()
    };
    try {
      final response = await ConnectService().postRefreshToken(
        refreshTokenUrl,
        params: map,
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => LoginRespone.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Logout
  Future<NetworkResponse<ResponseMessage>> logout() async {
    Map map = {
      'refreshToken': LocalStorage.getToken()?.refreshToken.toString()
    };
    try {
      final response = await ConnectService().post(
        logoutURL,
        params: map,
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Reset password
  Future<NetworkResponse<ResponseMessage>> resetPassword(String phone,String newPassword) async {
    Map map = {
      'phoneNumber':phone,
      'newPassword':newPassword,
    };
    try {
      final response = await ConnectService().put(
        logoutURL,
        params: map,
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }
}
