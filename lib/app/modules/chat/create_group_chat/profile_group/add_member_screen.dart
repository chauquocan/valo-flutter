import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/widgets/widget_appbar.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import '../create_group_chat_controller.dart';

class AddMemberScreen extends GetView<CreateGroupChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetAppBar(
        title: 'Add new member',
        actions: [
          controller.selected.length >= 1
              ? IconButton(
                  onPressed: () => controller.onSubmit(),
                  icon: Icon(Icons.add),
                  color: Colors.white,
                )
              : IconButton(
                  onPressed: () {
                    Get.rawSnackbar(
                      title: 'Something wrong',
                      message: 'Please select a friend',
                    );
                  },
                  icon: Icon(Icons.add),
                  color: Colors.white,
                )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: GetX<CreateGroupChatController>(
                builder: (_) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      _buildListUser(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

// get list user
  Expanded _buildListUser() {
    final l = controller.selected;
    return Expanded(
      child: ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, i) {
          final user = controller.users[i];
          return ListTile(
            onTap: () => controller.onSelect(user),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            leading: WidgetAvatar(
              url: user.imgUrl,
              isActive: false,
            ),
            title: Text(user.name),
            trailing: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: l.contains(user) ? Colors.green : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.grey.shade200,
                ),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
