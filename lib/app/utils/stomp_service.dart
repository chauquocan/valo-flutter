import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class StompService {
  static var stompClient = null;
  static var wsUrl = dotenv.env['WS_URL'];

  void startStomp(String numberPhone,String token) {
    if (stompClient == null) {
      initStomp(numberPhone,token);
    }
    stompClient.activate();
  }

  void desTroyStomp() {
    if (stompClient != null) {
      stompClient.deactivate();
    }
  }

  void initStomp(String numberPhone,String token) {
    stompClient = StompClient(
      config: StompConfig.SockJS(
          url: '${wsUrl}',
          onConnect: onConnect,
          onDisconnect: onDisconnect,
          beforeConnect: () async {
            print('connecting...');
          },
          onWebSocketError: (dynamic error) {
            print('websocket error');
            print(error.toString());
          },
          stompConnectHeaders: {
            'userId': numberPhone,
            'token': token,
          },
          webSocketConnectHeaders: {
            'userId': numberPhone,
            'token': token,
          }),
    );
  }

  void onConnect(StompFrame frame) {
    print("--Connected---");
  }

  dynamic onDisconnect(StompFrame frame) {
    print("--onDisconnect---");
  }

  dynamic onStompError(StompFrame frame) {
    print("--onStompError---");
    print(json.decode(frame.body.toString()));
  }
}
