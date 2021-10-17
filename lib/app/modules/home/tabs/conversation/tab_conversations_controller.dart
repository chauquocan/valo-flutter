import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/chat.dart';

class TabConversationController extends GetxController {
  List<ChatModel> chats = [
    ChatModel(
      name: "An",
      icon: '',
      isGroup: false,
      time: '18:30',
      currentMessage: 'Em an com chua',
      status: 'logo.svg',
    ),
    ChatModel(
      name: "Chau Quoc An",
      icon: 'logo.svg',
      isGroup: true,
      time: '4:20',
      currentMessage: 'lam hoi khong em',
    )
  ];
}
