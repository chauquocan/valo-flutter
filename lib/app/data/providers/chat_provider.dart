import 'dart:async';
import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';

class ChatProvider {
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations';
  static const String fileURL = '/upload';
  static const String deleteURL = '$messageURL/cancel';

  //Get conversations
  Future<NetworkResponse<ConversationPage>> getConversations(int page) async {
    try {
      final response = await ConnectService().get(
        conversationURL,
        params: {'page': page},
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ConversationPage.fromJson(json),
      );
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Get messages
  Future<NetworkResponse<MessagePage>> getMesages(String id, int page) async {
    try {
      final response = await ConnectService().get(
        messageURL + id,
        params: {'page': page},
      );
      return NetworkResponse.fromResponse(
          response, (json) => MessagePage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Get messages by type
  Future<NetworkResponse<MessagePage>> getMesagesByType(
      String id, String type, int page) async {
    try {
      final response = await ConnectService().get(
        '${messageURL}type/$id',
        params: {
          'type': type,
          'page': page,
        },
      );
      return NetworkResponse.fromResponse(
          response, (json) => MessagePage.fromJson(json));
    } on DioError catch (e) {
      return NetworkResponse.withError(e.response);
    }
  }

  //Pick file
  Future<Response> uploadFile(filePath) async {
    try {
      FormData formData =
          FormData.fromMap({"files": await MultipartFile.fromFile(filePath)});
      final response = await ConnectService().post(
        fileURL,
        params: formData,
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  //Pick file
  Future<Response> uploadFiles(List filePath) async {
    try {
      List<MultipartFile> files =
          filePath.map((e) => MultipartFile.fromFileSync(e)).toList();
      var formData = FormData.fromMap({"files": files});
      final response = await ConnectService().post(
        fileURL,
        params: formData,
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  //delele mess
  Future<Response> deleteMessage(String messageId) async {
    try {
      final response = await ConnectService().delete(
        '$deleteURL/$messageId',
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.error);
    }
  }
}
