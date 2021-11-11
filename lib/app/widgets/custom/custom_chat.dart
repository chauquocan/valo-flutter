import 'package:flutter/material.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:get/get.dart';

//Custom card in conversation tab
class CustomChatCard extends StatelessWidget {
  const CustomChatCard({Key? key, required this.chat}) : super(key: key);
  final ConversationCustom chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: () {
        Get.to(
          () => ChatScreen(chatModel: chat),
          binding: ChatBinding(),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              backgroundImage: NetworkImage('${chat.avatar}'),
            ),
            title: Text(
              chat.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: Text(chat.time),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chat.currentMessage,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
