import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/register.dart';
import '../models/user.dart';

class UserProvider extends ConnectService {
  static const String loginURL = 'auth/signin';
  static const String registerURL = 'auth/register';
  static const String userURL = 'users/';

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

  Future<NetworkResponse<UserResponse>> getUser(String accessToken) async {
    try {
      options.headers = {'Authorization': 'Bearer ${accessToken}'};
      final response = await get(userURL + Storage.getToken()!.username);
      print(userURL + Storage.getToken()!.username);
      return NetworkResponse.fromResponse(
        response,
        (json) => UserResponse.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<UserResponse>> uploadFile(filePath) async {
    var token = Storage.getToken()?.accessToken;
    var _userId = Storage.getUser()?.id;

    try {
      FormData formData = FormData.fromMap(
          {"image": await MultipartFile.fromFile(filePath, filename: "dp")});
      Response response = await patch(
        userURL + _userId!,
        data: formData,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => UserResponse.fromJson(json),
      );
    } on DioError catch (e) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }
}
