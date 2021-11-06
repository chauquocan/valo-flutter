import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/chat.dart';

class TabConversationController extends GetxController {
  final isLoading = false.obs;
  List<ChatModel> chats = [
    ChatModel(
      name: "Chau Quoc An",
      icon: 'logo.svg',
      isGroup: false,
      time: '4:20',
      currentMessage: 'Hi',
    ),
    ChatModel(
      name: "Long Tran",
      icon: 'logo.svg',
      isGroup: false,
      time: '15:20',
      currentMessage: 'Hello',
    )
  ];
}
