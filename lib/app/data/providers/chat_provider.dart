import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ChatProvider extends ConnectService {
  static const String userURL = 'users/';
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations';

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/user',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );

    Timer.periodic(Duration(seconds: 10), (_) {
      stompClient.send(
        destination: '/app/test/endpoints',
        body: json.encode({'a': 123}),
      );
    });
  }

  late final stompClient = StompClient(
    config: StompConfig(
      url: 'ws://192.168.1.102:3000/ws/websocket',
      onConnect: onConnect,
      // onDisconnect: onDisconnect,
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(Duration(milliseconds: 200));
        print('connecting...');
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      stompConnectHeaders: {
        'Authorization': 'Bearer ${Storage.getToken()!.accessToken}'
      },
      webSocketConnectHeaders: {
        'Authorization': 'Bearer ${Storage.getToken()!.accessToken}'
      },
    ),
  );

  dynamic onDisconnect(StompFrame frame) {
    print("--onDisconnect---");
  }

  dynamic onStompError(StompFrame frame) {
    print("--onStompError---");
    // print(json.decode(frame.body));
  }

  //Get conversations
  Future<NetworkResponse<ConversationPage>> GetConversations() async {
    try {
      final response = await get(
        conversationURL,
        options: Options(headers: {
          'Authorization': 'Bearer ${Storage.getToken()!.accessToken}',
        }),
      );
      print(response);
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
}
