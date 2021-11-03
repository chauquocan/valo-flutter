import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/data/models/chat.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:get/get.dart';

//Custom card in conversation tab
class CustomChatCard extends StatelessWidget {
  const CustomChatCard({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/chat");
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              child: SvgPicture.asset(
                chat.isGroup
                    ? 'assets/icons/group.svg'
                    : 'assets/icons/${chat.icon}',
                //color: AppColors.secondary,
                height: 38,
                width: 38,
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
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
