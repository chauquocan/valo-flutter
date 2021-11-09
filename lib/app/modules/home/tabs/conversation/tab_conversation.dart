import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_screen.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_screen.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/custom_chat.dart';

class ConversationTab extends GetView<TabConversationController> {
  ConversationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'chat'.tr,
          style: TextStyle(color: AppColors.light),
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/newfriend'),
              icon: Icon(Icons.search)),
          PopupMenuButton<String>(onSelected: (value) {
            switch (value) {
              case ("newgroup"):
                Get.toNamed('/creategroup');
                break;
              case ("newfriend"):
                Get.toNamed('/newfriend');
                break;
              case ("friendrequest"):
                Get.toNamed('/friendrequest');
                break;
            }
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("New friend"),
                value: "newfriend",
              ),
              PopupMenuItem(
                child: Text("New group"),
                value: "newgroup",
              ),
              PopupMenuItem(
                child: Text("Friend Request"),
                value: "friendrequest",
              ),
            ];
          })
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: Text('No coversation yet'))
          : ListView.builder(
              itemBuilder: (context, index) => CustomChatCard(
                chat: controller.conversations[index],
              ),
              itemCount: controller.conversations.length,
            )),
    );
  }
}
