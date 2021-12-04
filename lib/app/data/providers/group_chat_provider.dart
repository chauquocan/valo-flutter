import 'dart:convert';

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

  // Future<NetworkResponse>

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
}
