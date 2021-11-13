import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

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
        child: GetX<TabConversationController>(
          builder: (_) {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (controller.conversationsLoaded.value) {
                return ListView.builder(
                    itemCount: controller.conversations.length,
                    itemBuilder: (context, i) {
                      final conversation = controller.conversations[i];
                      return ListTile(
                        onLongPress: () {},
                        onTap: () => Get.toNamed('/chat', arguments: {
                          "id": conversation.id,
                          "name": conversation.name,
                          // "participants": conversation.participants,
                          "avatar": conversation.avatar,
                          "isGroup": conversation.isGroup,
                        }),
                        leading: Hero(
                          tag: conversation.id,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 30,
                            backgroundImage: NetworkImage(conversation.avatar),
                          ),
                        ),
                        title: Text(
                          conversation.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(conversation.time),
                        subtitle: Row(
                          children: [
                            Icon(Icons.done_all),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              conversation.lastMessage,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text(
                    'No conversation yet',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 18,
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
