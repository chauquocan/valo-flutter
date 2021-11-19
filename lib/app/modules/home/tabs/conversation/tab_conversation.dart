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
        title: Text('chat'.tr),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/newfriend'),
              icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
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
            },
            itemBuilder: (BuildContext context) {
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
            },
          )
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
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      final conversation = controller.conversations[i];
                      return ListTile(
                        onLongPress: () {},
                        onTap: () => Get.toNamed('/chat', arguments: {
                          "id": conversation.id,
                          "name": conversation.name,
                          // "participants": conversation.participants,
                          "avatar": conversation.imageUrl,
                          "isGroup": conversation.isGroup,
                        }),
                        leading: Hero(
                          tag: conversation.id,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 30,
                            backgroundImage:
                                NetworkImage(conversation.imageUrl),
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
                            conversation.unread > 0
                                ? Icon(
                                    Icons.fiber_manual_record,
                                    color: AppColors.primary,
                                  )
                                : Icon(Icons.done),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                              child: Text(
                                conversation.lastMessage,
                                style: conversation.unread > 0
                                    ? TextStyle(fontWeight: FontWeight.bold)
                                    : TextStyle(fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
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
