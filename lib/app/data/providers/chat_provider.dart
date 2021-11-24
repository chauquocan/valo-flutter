import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ChatProvider extends ConnectService {
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations';
  static const String fileURL = '/upload';

  //current token
  final _token = Storage.getToken()?.accessToken;

  //Get conversations
  Future<NetworkResponse<ConversationPage>> GetConversations(int page) async {
    try {
      final response = await get(
        conversationURL,
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_token}',
          },
        ),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ConversationPage.fromJson(json),
      );
    } on DioError catch (e, s) {
      print(e.error);
      print(s);
      return NetworkResponse.withError(e.response);
    }
  }

  //Get messages
  Future<NetworkResponse<MessagePage>> GetMessages(String id, int page) async {
    try {
      final response = await get(
        messageURL + id,
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_token}',
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

  //Pick file
  Future<Response> uploadFile(filePath) async {
    try {
      FormData formData =
          FormData.fromMap({"files": await MultipartFile.fromFile(filePath)});
      final response = await post(
        fileURL,
        data: formData,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      return response;
    } on DioError catch (e, s) {
      print(e.message);
      // return NetworkResponse.withError(e.response);
      throw Exception(e);
    }
  }

  //Pick file
  Future<Response> uploadFiles(List filePath) async {
    try {
      // var formData = FormData();
      // for (var file in filePath) {
      //   formData.files.addAll([
      //     MapEntry("files", await MultipartFile.fromFile(file)),
      //   ]);
      // }
      List<MultipartFile> files =
          filePath.map((e) => MultipartFile.fromFileSync(e)).toList();
      var formData = FormData.fromMap({"files": files});
      final response = await post(
        fileURL,
        data: formData,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      return response;
    } on DioError catch (e, s) {
      print(e.message);
      // return NetworkResponse.withError(e.response);
      throw Exception(e);
    }
  }

  //delele mess
  Future<Response> deleteMessage(String messageId) async {
    try {
      final response = await delete(
        '$messageURL/cancel/$messageId',
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $_token',
          },
        ),
      );
      return response;
    } on DioError catch (e, s) {
      throw Exception(e);
    }
  }
}
