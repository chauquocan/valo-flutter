import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class StompService {
  static var stompClient = null;
  static var wsUrl = dotenv.env['WS_URL'];

  void startStomp() {
    if (stompClient == null) {
      initStomp();
    }
    stompClient.activate();
  }

  void desTroyStomp() {
    if (stompClient != null) {
      stompClient.deactivate();
    }
  }

  void initStomp() {
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: '${wsUrl}',
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
  }

  void onConnect(StompFrame frame) {
    String mess = "";
    print("--Connected---");
    stompClient.subscribe(
      destination: '/topic/message',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print(result);
      },
    );

    print(mess);
  }

  dynamic onDisconnect(StompFrame frame) {
    print("--onDisconnect---");
  }

  dynamic onStompError(StompFrame frame) {
    print("--onStompError---");
    print(json.decode(frame.body.toString()));
  }
}
