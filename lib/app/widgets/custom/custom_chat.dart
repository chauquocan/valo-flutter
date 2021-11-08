import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/data/models/conversation.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:get/get.dart';

//Custom card in conversation tab
class CustomChatCard extends StatelessWidget {
  const CustomChatCard({Key? key, required this.chat}) : super(key: key);
  final ConversationModel chat;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Get.to(
                  () => ChatScreen(
                        chatModel: chat,
                      ),
                  binding: ChatBinding());
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              child: SvgPicture.asset(
                chat.isGroup
                    ? 'assets/icons/group.svg'
                    : 'assets/icons/${chat.icon}',
                //color: AppColors.secondary,
                height: 40,
                width: 40,
              ),
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
          const Padding(
            padding: EdgeInsets.zero,
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
