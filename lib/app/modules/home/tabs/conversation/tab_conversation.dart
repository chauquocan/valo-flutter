import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/customcard.dart';

class ConversationTab extends GetView<TabConversationController> {
  const ConversationTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'chat'.tr,
            style: TextStyle(color: AppColors.primary),
          ),
          backgroundColor: AppColors.light,
          actions: <Widget>[],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => CustomCard(
            chat: controller.chats[index],
          ),
          itemCount: controller.chats.length,
        ));
  }
}
