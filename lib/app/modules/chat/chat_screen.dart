import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/profile_group/profile_group_creen.dart';
import 'package:valo_chat_app/app/modules/chat/video/video_call.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_screen.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, i) {
                        final item = controller.messages[i];
                        return GestureDetector(
                          onLongPress: () {},
                          child: WidgetBubble(
                            message: item.content,
                            isMe: item.senderId == controller.currentUserId,
                            dateTime: DateFormat('h:mm a').format(item.sendAt),
                            type: item.messageType,
                            avatar: controller.avatar,
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
            sendImageFromGallery: () =>
                // controller.pickImageFromCamera(ImageSource.gallery),
                controller.pickImagesFromGallery(),
            sendIcon: () => controller.emojiShowing = !controller.emojiShowing,
            sendSticker: () =>
                controller.stickerShowing = !controller.stickerShowing,
            // sendGif: () => controller.gifShowing = !controller.gifShowing,
            sendGif: () => controller.sendGif(context),

            sendFile: () => controller.pickFilesFromGallery(),
            isEmojiVisible: controller.emojiShowing,
            isKeyboardVisible: controller.isKeyboardVisible,
          ),
          _buildEmoji(),
          _buildSticker(),
          _buildGif(),
        ],
      ),
    );
  }

  Widget _buildGif() {
    return GetX<ChatController>(
      builder: (_) {
        return Visibility(
            visible: controller.gifShowing, child: WidgetSticker());
      },
    );
  }

  Widget _buildSticker() {
    return GetX<ChatController>(
      builder: (_) {
        return Visibility(
            visible: controller.stickerShowing, child: WidgetSticker());
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      leadingWidth: 70,
      titleSpacing: 0,
      leading: InkWell(
        onTap: () {
          Get.offNamed('/home');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              size: 30,
            ),
            Hero(
              tag: controller.id,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                backgroundImage: NetworkImage(controller.avatar),
              ),
            ),
          ],
        ),
      ),
      title: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.name,
              style: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'last seen today',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(VideoCallScreen());
          },
          icon: Icon(Icons.videocam),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.call),
        ),
        IconButton(
          onPressed: () {
            if (controller.isGroup == true) {
              Get.to(ProfileGroupScreen(), arguments: ['uid']);
            } else
              Get.to(ProfileFriendScreen());
          },
          icon: Icon(Icons.list_outlined),
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
            margin: EdgeInsets.all(10),
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
