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
  void initStomp() {
    stompClient = StompClient(
      config: StompConfig(
        url:
            // 'ws://ec2-3-0-183-214.ap-southeast-1.compute.amazonaws.com:3000/ws/websocket',
            '${wsUrl}',
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

  dynamic onDisconnect(StompFrame frame) {
    print("--onDisconnect---");
  }

  dynamic onStompError(StompFrame frame) {
    print("--onStompError---");
    print(json.decode(frame.body.toString()));
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/user',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );
    
  }
}
