import 'package:firebase_auth/firebase_auth.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';

class Group {
  final String uid;
  final String name;
  // final MessageModel? lastMessage;
  final List<User> members;

  const Group({
    required this.uid,
    required this.name,
    // this.lastMessage,
    required this.members,
  });
}
