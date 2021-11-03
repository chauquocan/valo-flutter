import 'dart:async';

import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/message.dart';

class ChatProvider extends ConnectService {
  static const String userURL = 'users/';
  static const String messageURL = 'messages/';
  static const String conversationURL = 'conversations/';

  // Stream<List<MessageModel>> getMessages(
  //     String id, String accessToken)  {

  //   }

}
