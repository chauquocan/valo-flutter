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

  //Get friend request
  Future<NetworkResponse<FriendRequestPage>> getFriendRequests() async {
    try {
      final response = await ConnectService().get(
        getFriendRequestUrl,
        options: Options(headers: {
          'Authorization':
              'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
        }),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => FriendRequestPage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Send friend request
  Future<NetworkResponse<ResponseMessage>> sendFriendRequest(
      String toId) async {
    try {
      final response = await ConnectService().post(
        '$sendfriendRequestUrl$toId',
        options: Options(headers: {
          'Authorization':
              'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
        }),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Accept friend request
  Future<NetworkResponse<ResponseMessage>> acceptFriendRequest(
      String id) async {
    try {
      final response = await ConnectService().put(
        '$accpectFriendRequestUrl/$id',
        options: Options(headers: {
          'Authorization':
              'Bearer ${LocalStorage.getToken()?.accessToken.toString()}'
        }),
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
