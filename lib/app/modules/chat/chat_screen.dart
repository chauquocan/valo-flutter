import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';
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
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (controller.messagesLoaded) {
                    return ListView.builder(
                      // controller: controller.scrollController,
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, i) {
                        final item = controller.messages[i];
                        return WidgetBubble(
                          message: item.content,
                          isMe: item.senderId == Storage.getUser()?.id,
                          dateTime: DateFormat('hh:mm dd-MM-yyyy')
                              .format(DateTime.parse(item.sendAt)),
                          type: item.messageType,
                          avatar: controller.avatar,
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No messages'));
                  }
                }
              },
            ),
          ),
          buildListTag(),
          WidgetInputField(
            textEditingController: controller.textController,
            onSubmit: () => controller.sendMessage(controller.id),
            sendIcon: () {
              controller.emojiShowing = !controller.emojiShowing;
            },
            sendSticker: () {
              controller.stickerShowing = !controller.stickerShowing;
            },
            sendImage: () {
              //controller.sendImage();
            },
            isEmojiVisible: controller.emojiShowing,
            isKeyboardVisible: controller.isKeyboardVisible,
          ),
          _buildEmoji(),
          GetX<ChatController>(
            builder: (_) {
              return Visibility(
                  visible: controller.stickerShowing, child: WidgetSticker());
            },
          ),
        ],
      ),
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
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey,
              backgroundImage: NetworkImage(controller.avatar),
              // child: SvgPicture.asset(
              //   controller.isGroup
              //       ? 'assets/icons/logo.svg'
              //       : 'assets/icons/signup.svg',
              //   color: AppColors.secondary,
              //   height: 36,
              //   width: 36,
              // ),
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
          onPressed: () {},
          icon: Icon(Icons.video_call),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.call),
        ),
        IconButton(
          onPressed: () {
            Get.to(ProfileFriend());
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
