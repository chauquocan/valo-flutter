import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class FriendProvider extends ConnectService {
  //end point
  static const String getFriendRequestUrl = '/friend-request';
  static const String sendfriendRequestUrl = '/friend-request/to/';
  static const String accpectFriendRequestUrl = '/friend-request';

  //curent userId
  final _userId = Storage.getUser()?.id;

  //Get friend request
  Future<NetworkResponse<FriendReqModel>> GetFriendRequest(
      String accessToken) async {
    try {
      final response = await get(
        getFriendRequestUrl,
        options: Options(headers: {'Authorization': 'Bearer ${accessToken}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => FriendReqModel.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }
  //Send friend request

  //Accept friend request
}
