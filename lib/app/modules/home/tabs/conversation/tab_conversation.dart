import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/custom_chat.dart';

class ConversationTab extends GetView<TabConversationController> {
  ConversationTab({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.conversationsLoaded.value
                  ? ListView.builder(
                      itemBuilder: (context, index) => CustomChatCard(
                        chat: controller.conversations[index],
                      ),
                      itemCount: controller.conversations.length,
                      
                    )
                  : const Center(
                      child: Text(
                        'No conversation yet',
                        style: TextStyle(
                          color: AppColors.dark,
                          fontSize: 18,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
