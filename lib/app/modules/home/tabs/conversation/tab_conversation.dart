import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_screen.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_screen.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/profile_friend.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/customcard.dart';

class ConversationTab extends GetView<TabConversationController> {
  const ConversationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'chat'.tr,
            style: TextStyle(color: AppColors.light),
          ),
          backgroundColor: Colors.lightBlue,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton<String>(onSelected: (value) {
              switch (value) {
                case ("newgroup"):
                  Get.to(CreateGroupChatScreen());
                  break;
                case ("newfriend"):
                  Get.to(AddFriendScreen());
                  break;
              }
            }, itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New friend"),
                  value: "newfriend",
                ),
                PopupMenuItem(child: Text("New group"), value: "newgroup"),
                PopupMenuItem(child: Text("Setting"), value: "setting"),
              ];
            })
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => CustomCard(
            chat: controller.chats[index],
          ),
          itemCount: controller.chats.length,
        ));
  }
}
