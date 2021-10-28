import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/customcard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConversationTab extends GetView<TabConversationController> {
  ConversationTab({Key? key}) : super(key: key);
  //socket
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri(scheme: 'ws', host: 'localhost', port: 3000, path: '/ws'));

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
              print(value);
            }, itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("New friend"), value: "New friend"),
                PopupMenuItem(child: Text("New group"), value: "New group"),
                PopupMenuItem(child: Text("Setting"), value: "Setting"),
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
