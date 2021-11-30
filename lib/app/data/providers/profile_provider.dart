import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import '../connect_service.dart';
import '../models/network_response.dart';
import '../models/profile_model.dart';

class ProfileProvider {
  static const String userURL = 'users';
  static const String searchURL = '${userURL}/search';
  static const String userPhoneURL = '${userURL}/phone=';
  static const String updateURL = '${userURL}/update';
  static const String changImageURL = '${userURL}/me/changeImage';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //current rfToken
  final _refreshToken = Storage.getToken()?.refreshToken;
  //curent userId
  final _userId = Storage.getUser()?.id;

  //Get user bằng số id
  Future<NetworkResponse<Profile>> getUserById(String id) async {
    try {
      final response = await ConnectService().get('${userURL}/${id}',
          options: Options(headers: {'Authorization': 'Bearer $_token'}));
      return NetworkResponse.fromResponse(
        response,
        (json) => Profile.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get user bằng số điện thoại
  Future<NetworkResponse<Profile>> getUserByPhone(
      String numberPhone, String accessToken) async {
    try {
      final response = await ConnectService().get(
          '${userPhoneURL}${numberPhone}',
          options:
              Options(headers: {'Authorization': 'Bearer ${accessToken}'}));
      print(userURL + Storage.getToken()!.username);
      return NetworkResponse.fromResponse(
        response,
        (json) => Profile.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Update user info
  Future<NetworkResponse<Profile>> updateUserInfo(Map map) async {
    try {
      final response = await ConnectService().patch(
        '${updateURL}',
        params: map,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer $_token'},
        ),
      );
      print(response.statusCode);
      return NetworkResponse.fromResponse(
          response, (json) => Profile.fromJson(json));
    } on DioError catch (e) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }

  //Search user
  Future<NetworkResponse<ProfilePage>> searchUser(String textToSearch) async {
    try {
      final response = await ConnectService().get(searchURL,
          params: {
            'textToSearch': textToSearch,
          },
          options: Options(headers: {'Authorization': 'Bearer $_token'}));
      return NetworkResponse.fromResponse(
        response,
        (json) => ProfilePage.fromJson(json),
      );
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  //upload hình
  Future<NetworkResponse<Profile>> uploadFile(filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "multipartFile": await MultipartFile.fromFile(filePath, filename: 'avt')
      });
      Response response = await ConnectService().put(
        changImageURL,
        params: formData,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => Profile.fromJson(json),
      );
    } on DioError catch (e) {
      print(e.error);
      return NetworkResponse.withError(e.response);
    }
  }
}
