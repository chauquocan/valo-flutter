import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';
import 'package:valo_chat_app/app/modules/group_chat/group.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_screen.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
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
                          final item = controller.messages[i];
                          return FocusedMenuHolder(
                            blurSize: 0,
                            menuItems: <FocusedMenuItem>[
                              FocusedMenuItem(
                                title: const Text('Delete'),
                                trailingIcon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.deleteMessage(item.message.id);
                                },
                              )
                            ],
                            onPressed: () {},
                            child: WidgetBubble(
                              message: item.message.content,
                              isMe: item.message.senderId ==
                                  controller.currentUserId,
                              dateTime: DateFormat('h:mm a')
                                  .format(DateTime.parse(item.message.sendAt)),
                              type: item.message.messageType,
                              status: item.message.messageStatus,
                              avatar: item.userImgUrl,
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
        return AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: SizedBox(
            height: controller.stickerShowing ? null : 0.0,
            child: const WidgetSticker(),
          ),
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
            config: const Config(
              columns: 7,
              emojiSizeMax: 32.0,
              verticalSpacing: 0,
              horizontalSpacing: 0,
              initCategory: Category.RECENT,
              bgColor: Color(0xFFF2F2F2),
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

  AppBar _appBar() {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      leadingWidth: 40,
      titleSpacing: 0,
      leading: InkWell(
        onTap: () {
          Get.offNamed('/home');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            // Hero(
            //   tag: controller.id,
            //   child: CircleAvatar(
            //     radius: 20,
            //     backgroundColor: Colors.blueGrey,
            //     backgroundImage: NetworkImage(controller.avatar),
            //   ),
            // ),
          ],
        ),
      ),
      title: Container(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Hero(
              tag: controller.id,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                backgroundImage: NetworkImage(controller.avatar),
              ),
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
                // const Text(
                //   'last seen today',
                //   style: TextStyle(
                //     fontSize: 13,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        // IconButton(
        //   onPressed: () {
        // Get.to(VideoCallScreen());
        //   },
        //   icon:const Icon(Icons.videocam),
        // ),
        // IconButton(
        //   onPressed: () {},
        //   icon:const Icon(Icons.call),
        // ),
        IconButton(
          onPressed: () {
            if (controller.isGroup == true) {
              Get.to(() => ProfileGroupScreen(), arguments: ['uid']);
            } else
              Get.to(() => ProfileFriendScreen());
          },
          icon: const Icon(Icons.list_outlined),
        ),
      ],
    );
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
