import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/chat.dart';

class TabConversationController extends GetxController {
  List<ChatModel> chats = [
    ChatModel(
      name: "Cong Nghe Moi",
      icon: '',
      isGroup: true,
      time: '18:30',
      currentMessage: 'Em an com chua',
      status: 'logo.svg',
    ),
    ChatModel(
      name: "Chau Quoc An",
      icon: 'logo.svg',
      isGroup: false,
      time: '4:20',
      currentMessage: 'lam hoi khong em',
    ),
    ChatModel(
      name: "Long Tran",
      icon: 'logo.svg',
      isGroup: false,
      time: '4:20',
      currentMessage: 'lam hoi khong em',
    )
  ];
}
