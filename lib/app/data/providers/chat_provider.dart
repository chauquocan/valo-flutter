import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/message.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';
import 'package:web_socket_channel/io.dart';

class ChatProvider extends ConnectService {
  static const String userURL = 'users/';
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations/';

  // Stream<List<MessageModel>> getMessages(
  //     String id, String accessToken)  {

  //   }
  // late IOWebSocketChannel channel;
  // connectChannel() {
  //   try {
  //     channel =
  //         IOWebSocketChannel.connect(Uri.parse('ws://192.168.1.101:3000/ws'));
  //     channel.stream.listen(
  //       (message) {
  //         print(message);
  //       },
  //       onDone: () {
  //         //if WebSocket is disconnected
  //         print("Web socket is closed");
  //       },
  //       onError: (error) {
  //         print(error.toString());
  //       },
  //     );
  //   } catch (_) {
  //     print("error on connecting to websocket.");
  //   }
  // }
  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/test/subscription',
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

  final stompClient = StompClient(
    config: StompConfig(
      url: 'ws://192.168.1.101:3000/ws',
      // onConnect: onConnect(),
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(Duration(milliseconds: 200));
        print('connecting...');
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      stompConnectHeaders: {
        'Authorization': '${Storage.getToken()!.accessToken}'
      },
      webSocketConnectHeaders: {
        'Authorization': '${Storage.getToken()!.accessToken}'
      },
    ),
  );
}
