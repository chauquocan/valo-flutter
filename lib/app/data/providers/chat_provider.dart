import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ChatProvider extends ConnectService {
  static const String userURL = 'users/';
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations';

  //Get conversations
  Future<NetworkResponse<ConversationPage>> GetConversations(int page) async {
    try {
      final response = await get(
        conversationURL,
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Storage.getToken()!.accessToken}',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ConversationPage.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      print(e.response?.data);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get messages
  Future<NetworkResponse<MessagePage>> GetMessages(String id,int page) async {
    try {
      final response = await get(
        messageURL + id,
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Storage.getToken()!.accessToken}',
          },
        ),
      );
      return NetworkResponse.fromResponse(
          response, (json) => MessagePage.fromJson(json));
    } on DioError catch (e, s) {
      print(e.error);
      print(e.response?.data);
      return NetworkResponse.withError(e.response);
    }
  }
}
