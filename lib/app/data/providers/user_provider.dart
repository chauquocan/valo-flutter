import 'package:dio/dio.dart';
import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/user_model.dart';

class ProfileProvider {
  static const String userURL = 'users';
  static const String searchURL = '$userURL/search';
  static const String suggestURL = '$userURL/suggest';
  static const String userPhoneURL = '$userURL/phone=';
  static const String updateURL = '$userURL/update';
  static const String changImageURL = '$userURL/me/changeImage';

  //Get user bằng số id
  Future<NetworkResponse<User>> getUserById(String id) async {
    try {
      final response = await ConnectService().get(
        '$userURL/$id',
      );
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
      final response = await ConnectService().get('$userPhoneURL$numberPhone',
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
      final response = await ConnectService().get(
        searchURL,
        params: {
          'textToSearch': textToSearch,
        },
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => UserPage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Search user by address
  Future<NetworkResponse<UserPage>> searchUserByAddress(String address) async {
    try {
      final response = await ConnectService().get(
        suggestURL,
        params: {
          'address': address,
        },
      );
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
      FormData formData = FormData.fromMap(
          {"multipartFile": await MultipartFile.fromFile(filePath)});
      Response response = await ConnectService().put(
        changImageURL,
        params: formData,
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => User.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<UserPage>> getUsersFromContact(
      List<String?> phoneNumbers) async {
    try {
      final response = await ConnectService().post('$userURL/phoneNumbers',
          params: {"phoneNumbers": phoneNumbers});
      return NetworkResponse.fromResponse(
          response, (json) => UserPage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }
}
