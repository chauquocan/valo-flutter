import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/date.dart';

class ConversationTab extends GetView<TabConversationController> {
  const ConversationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'btnConversation',
        child: const Tooltip(message: 'Tạo nhóm', child: Icon(Icons.add)),
        onPressed: () => Get.toNamed('/creategroup'),
      ),
      appBar: AppBar(
        title: Text('chat'.tr),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/newfriend'),
              icon: const Tooltip(
                  message: 'Tìm bạn', child: const Icon(Icons.search))),
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
                          "id": conversation.conversation.id,
                          "name": conversation.conversation.name,
                          "participants":
                              conversation.conversation.participants,
                          "avatar": conversation.conversation.imageUrl,
                          "isGroup": conversation.isGroup,
                          "unreadMess": conversation.unReadMessage,
                        }),
                        leading: Hero(
                          tag: conversation.conversation.id,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                              conversation.conversation.imageUrl,
                            ),
                          ),
                        ),
                        title: Text(
                          conversation.conversation.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          formatDate(conversation.lastMessage.message.sendAt),
                        ),
                        subtitle: Row(
                          children: [
                            conversation.unReadMessage > 0
                                ? const Icon(
                                    Icons.fiber_manual_record,
                                    color: AppColors.primary,
                                  )
                                : const Icon(Icons.done),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                              child: Text(
                                controller.lastMess(conversation),
                                style: conversation.unReadMessage > 0
                                    ? const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)
                                    : const TextStyle(fontSize: 13),
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
