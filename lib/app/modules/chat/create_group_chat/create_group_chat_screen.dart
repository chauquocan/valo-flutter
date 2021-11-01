import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widget_appbar.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class CreateGroupChatScreen extends GetView<CreateGroupChatController> {
  @override
  Widget build(BuildContext context) {
    return GetX<CreateGroupChatController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: WidgetAppBar(
            title: 'Create group chat',
            actions: [
              controller.selected.length > 2
                  ? IconButton(
                      onPressed: () => controller.onSubmit(),
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    )
                  : IconButton(
                      onPressed: () {
                        Get.rawSnackbar(
                          title: 'Something wrong',
                          message: 'Members must be up to 2',
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
                          WidgetField(
                            controller: controller.textCtrl,
                            hint: 'Enter group name',
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                          ),
                          SizedBox(height: 10),
                          //buildListSelected(),
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
      },
    );
  }

// get list user
  Expanded _buildListUser() {
    final l = controller.selected;
    return Expanded(
      child: ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, i) {
          final item = controller.users[i];
          return ListTile(
            onTap: () => controller.onSelect(item),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            leading: WidgetAvatar(
              url: item.imgUrl,
              isActive: false,
            ),
            title: Text(item.name),
            trailing: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: l.contains(item) ? Colors.green : Colors.white,
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
