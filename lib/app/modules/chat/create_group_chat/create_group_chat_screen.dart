import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class CreateGroupChatScreen extends StatelessWidget {
  final controller = Get.lazyPut(() => CreateGroupChatScreen());

  CreateGroupChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            WidgetField(
              //controller: controller.textCtrl,
              hint: 'Enter group name',
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Create new group',
      style: TextStyle(color: AppColors.light),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
