import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/contact_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/register_model.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class FriendProvider extends ConnectService {
  //end point
  static const String getFriendRequestUrl = '/friend-request';
  static const String sendfriendRequestUrl = '/friend-request/to/';
  static const String accpectFriendRequestUrl = '/friend-request';
  static const String getFriendsUrl = '/friends';

  //curent userId
  final _userId = Storage.getUser()?.id;

  //Get frineds
  Future<List<FriendModel>> GetFriends(String accessToken) async {
    try {
      final response = await get(
        '${getFriendsUrl}',
        options: Options(headers: {'Authorization': 'Bearer ${accessToken}'}),
      );
      return (response.data['content'] as List)
          .map((e) => FriendModel.fromJson(e))
          .toList();
    } on DioError catch (e, s) {
      throw Exception("$e///////////$s");
    }
  }

  //Get friend request
  // Future<NetworkResponse<List<Content>>> GetFriendRequests(
  Future<List<FriendContent>> GetFriendRequests(String accessToken) async {
    try {
      final response = await get(
        '$getFriendRequestUrl',
        options: Options(headers: {'Authorization': 'Bearer ${accessToken}'}),
      );
      // return NetworkResponse.fromResponse(
      //     response,
      return (response.data['content'] as List)
          .map((e) => FriendContent.fromJson(e))
          .toList();
      // );
    } on DioError catch (e, s) {
      // return NetworkResponse.withError(e.response);
      throw Exception("$e///////////$s");
    }
  }

  //Send friend request
  Future<NetworkResponse<ResponseMessage>> SendFriendRequest(
      String accessToken, String toId) async {
    try {
      final response = await post(
        '${sendfriendRequestUrl}${toId}',
        options: Options(headers: {'Authorization': 'Bearer ${accessToken}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Accept friend request
  Future<NetworkResponse<ResponseMessage>> AcceptFriendRequest(
      String accessToken, String id) async {
    try {
      final response = await put(
        '${accpectFriendRequestUrl}/${id}',
        options: Options(headers: {'Authorization': 'Bearer ${accessToken}'}),
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
