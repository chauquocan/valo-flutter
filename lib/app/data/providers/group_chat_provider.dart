import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/group_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/data/models/response_model.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class GroupChatProvider {
  static const String userURL = 'users/';
  static const String conversationURL = 'conversations/';
  static const String friendURL = 'friends/';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //curent userId
  final _userId = Storage.getUser()?.id;

  Future<NetworkResponse<Conversation>> createGroupChat(Map map) async {
    try {
      final response = await ConnectService().post(
        conversationURL,
        params: map,
        options: Options(headers: {'Authorization': 'Bearer ${_token}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => Conversation.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<ResponseMessage>> addMember(Map map) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/add',
        params: map,
        options: Options(headers: {'Authorization': 'Bearer ${_token}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<ResponseMessage>> kickMember(Map map) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/kick',
        params: map,
        options: Options(headers: {'Authorization': 'Bearer ${_token}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<ResponseMessage>> deleteGroup(String id) async {
    try {
      final response = await ConnectService().delete(
        '$conversationURL/delete/${id}',
        options: Options(headers: {'Authorization': 'Bearer ${_token}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }

  Future<NetworkResponse<ResponseMessage>> leaveGroup(String id) async {
    try {
      final response = await ConnectService().put(
        '$conversationURL/leave/${id}',
        options: Options(headers: {'Authorization': 'Bearer ${_token}'}),
      );
      return NetworkResponse.fromResponse(
          response, (json) => ResponseMessage.fromJson(json));
    } on DioError catch (e, s) {
      return NetworkResponse.withError(e.response);
    }
  }
}
