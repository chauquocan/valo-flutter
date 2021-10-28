import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widget_appbar.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import 'create_group_chat_controller.dart';

class CreateGroupChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<CreateGroupChatController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: GetX<CreateGroupChatController>(
                    builder: (_) {
                      return Column(
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
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'My account',
      style: TextStyle(color: AppColors.light),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
