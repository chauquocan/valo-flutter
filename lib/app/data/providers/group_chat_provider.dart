import 'package:valo_chat_app/app/data/models/message.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class GroupChatProvider {
  static const String userURL = 'users/';
  static const String conversationURL = 'conversations/';
  static const String friendURL = 'friends/';

  //current token
  final _token = Storage.getToken()?.accessToken;
  //curent userId
  final _userId = Storage.getUser()?.id;
}
