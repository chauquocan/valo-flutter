import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/response_model.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class FriendRequestProvider {
  static const String getFriendRequestUrl = '/friend-request';
  static const String sendfriendRequestUrl = '/friend-request/to/';
  static const String accpectFriendRequestUrl = '/friend-request';

  final _token = Storage.getToken()?.accessToken;

  //Get friend request
  // Future<NetworkResponse<List<Content>>> GetFriendRequests(
  Future<NetworkResponse<FriendRequestPage>> GetFriendRequests() async {
    try {
      final response = await ConnectService().get(
        '$getFriendRequestUrl',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => FriendRequestPage.fromJson(json),
      );
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Send friend request
  Future<NetworkResponse<ResponseMessage>> SendFriendRequest(
      String toId) async {
    try {
      final response = await ConnectService().post(
        '${sendfriendRequestUrl}${toId}',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Accept friend request
  Future<NetworkResponse<ResponseMessage>> AcceptFriendRequest(
      String id) async {
    try {
      final response = await ConnectService().put(
        '${accpectFriendRequestUrl}/${id}',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ResponseMessage.fromJson(json),
      );
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }
}
