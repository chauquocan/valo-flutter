import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/src/utils/date_time_utils.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/modules/Network/network_controller.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/chat_detail_binding.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/chat_detail_screen.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';
import 'package:valo_chat_app/app/modules/group_chat/group.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  ChatScreen({Key? key}) : super(key: key);
  final networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onBackPress(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          titleSpacing: 0,
          title: Container(
              margin: const EdgeInsets.all(5),
              child: Obx(
                () => Row(
                  children: [
                    Hero(
                      tag: controller.id,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Get.isDarkMode ? Colors.white : Colors.blueGrey,
                        backgroundImage:
                            CachedNetworkImageProvider(controller.avatar),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name,
                          style: const TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          actions: [
            IconButton(
              onPressed: () {
                if (controller.isGroup == true) {
                  Get.to(() => ProfileGroupScreen(), arguments: ['uid']);
                } else
                  Get.to(() => ChatDetailScreen(),
                      binding: ChatDetailBinding());
              },
              icon: const Icon(Icons.list_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GetX<ChatController>(
                builder: (_) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (controller.messagesLoaded) {
                      return ListView.builder(
                        controller: controller.scrollController,
                        reverse: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, i) {
                          final message = controller.messages[i];
                          MessageContent? messageBefore =
                              controller.messages[i.sign];
                          return FocusedMenuHolder(
                            blurSize: 0,
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                backgroundColor: Get.isDarkMode
                                    ? Colors.black54
                                    : Colors.white,
                                title: Text('Delete'),
                                trailingIcon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.deleteMessage(message.message.id);
                                },
                              ),
                              if (message.message.content.isURL &&
                                  message.message.messageType != "TEXT")
                                FocusedMenuItem(
                                  backgroundColor: Get.isDarkMode
                                      ? Colors.black54
                                      : Colors.white,
                                  title: Text('Download'),
                                  trailingIcon: const Icon(Icons.download),
                                  onPressed: () {
                                    controller.downloadFile(
                                      message.message.content,
                                      message.message.content.split("/").last,
                                    );
                                  },
                                )
                            ],
                            onPressed: () {},
                            child: WidgetBubble(
                              id: message.message.id,
                              message: message.message.content,
                              isMe: message.message.senderId ==
                                  controller.currentUserId,
                              senderName: message.userName,
                              dateTime: message.message.sendAt.timeAgo,
                              type: message.message.messageType,
                              status: message.message.messageStatus,
                              avatar: message.userImgUrl,
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No messages'));
                    }
                  }
                },
              ),
            ),
            buildListTag(),
            WidgetInputField(
              textEditingController: controller.textController,
              onSubmit: () => controller.sendTextMessage(),
              sendImageFromCamera: () => controller.pickImageFromCamera(),
              sendImageFromGallery: () => controller.pickImagesFromGallery(),
              sendVideoFromGallery: () => controller.pickVideoFromGallery(),
              sendIcon: () =>
                  controller.emojiShowing = !controller.emojiShowing,
              sendSticker: () =>
                  controller.stickerShowing = !controller.stickerShowing,
              sendGif: () => controller.sendGif(context),
              sendFile: () => controller.pickFilesFromGallery(),
              isEmojiVisible: controller.emojiShowing,
              isKeyboardVisible: controller.isKeyboardVisible,
            ),
            _buildEmoji(),
            _buildSticker(),
          ],
        ),
      ),
    );
  }

  Widget _buildSticker() {
    return GetX<ChatController>(
      builder: (_) {
        return SizedBox(
          height: controller.stickerShowing ? null : 0.0,
          child: const WidgetSticker(),
        );
        // return Visibility(
        //     visible: controller.stickerShowing, child: const WidgetSticker());
      },
    );
  }

  Widget _buildEmoji() {
    return GetX<ChatController>(builder: (_) {
      return Offstage(
        offstage: !controller.emojiShowing,
        child: SizedBox(
          height: 250,
          child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              controller.onEmojiSelected(emoji);
            },
            onBackspacePressed: () {
              controller.onBackspacePressed();
            },
            config: Config(
              columns: 7,
              emojiSizeMax: 32.0,
              verticalSpacing: 0,
              horizontalSpacing: 0,
              initCategory: Category.RECENT,
              bgColor:
                  Get.isDarkMode ? Colors.grey.shade900 : Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              backspaceColor: Colors.blue,
              showRecentsTab: true,
              recentsLimit: 28,
              noRecentsText: 'No Recents',
              noRecentsStyle: TextStyle(fontSize: 20, color: Colors.black26),
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          ),
        ),
      );
    });
  }

  Widget buildListTag() {
    return GetX<ChatController>(
      builder: (_) {
        return Visibility(
          visible: controller.tagging,
          child: Container(
            height: 160,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.membersWithoutMe.length,
              itemBuilder: (context, i) {
                final item = controller.membersWithoutMe[i];
                return ListTile(
                  onTap: () => WidgetAvatar(
                    url: item.imgUrl,
                    size: 40,
                  ),
                  title: Text(item.name),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
