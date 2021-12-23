import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/response_model.dart';

class GroupChatProvider {
  static const String userURL = 'users/';
  static const String conversationURL = 'conversations/';
  static const String membersCanAddURL = '$conversationURL/add/';
  static const String friendURL = 'friends/';

  /* 
    Create group chat
    Params: map:{ name, participants }
   */
  Future<NetworkResponse<Conversation>> createGroupChat(Map map) async {
    try {
      final response = await ConnectService().post(
        conversationURL,
        params: map,
      );
      return NetworkResponse.fromResponse(
          response, (json) => Conversation.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Add member to group chat
    Params: map:{ userId, conversationId }
   */
  Future<NetworkResponse<ListParticipant>> addMember(Map map) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/add',
        params: map,
      );
      return NetworkResponse.fromResponse(
          response, (json) => ListParticipant.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Kick member out
    Params:{ userId, conversationId }
   */
  Future<NetworkResponse<ListParticipant>> kickMember(Map map) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/kick',
        params: map,
      );
      return NetworkResponse.fromResponse(
          response, (json) => ListParticipant.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Delete group chat (admin)
    Params: conversationId
   */
  Future<NetworkResponse<ResponseMessage>> deleteGroup(String id) async {
    try {
      final response = await ConnectService().delete(
        '$conversationURL/delete/$id',
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Leave group chat
    Params: conversationId
   */
  Future<NetworkResponse<ResponseMessage>> leaveGroup(String id) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/leave/$id',
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Get friends can add to group
    Params: conversationId
   */
  Future<NetworkResponse<ListFriendsCanAdd>> getFriendsCanAddToGroup(
      String conversationId) async {
    try {
      final response = await ConnectService().get(
        '$membersCanAddURL$conversationId',
      );
      return NetworkResponse.fromResponse(
          response, (json) => ListFriendsCanAdd.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Change group avatar
    Params: conversationId, image
   */
  Future<NetworkResponse<Conversation>> uploadFile(
      String conversatiobID, filePath) async {
    try {
      FormData formData = FormData.fromMap(
          {"multipartFile": await MultipartFile.fromFile(filePath)});
      Response response = await ConnectService().put(
        '$conversationURL/$conversatiobID/changeImage',
        params: formData,
      );
      return NetworkResponse.fromResponse(
          response, (json) => Conversation.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  /* 
    Change group's name
    Params: newName, conversationId
   */
  Future<NetworkResponse<Conversation>> renameGroup(
      Map newName, String conversatiobID) async {
    try {
      final response = await ConnectService()
          .put('$conversationURL/rename/$conversatiobID', queryParams: newName);
      return NetworkResponse.fromResponse(
          response, (json) => Conversation.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }
}
