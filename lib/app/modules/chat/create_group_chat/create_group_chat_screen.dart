import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class CreateGroupChatScreen extends GetView<CreateGroupChatController> {
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
            SizedBox(height: 10),
            //_buildListUser(),
          ],
        ),
      ),
    );
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
              url: 'assets/icons/logo.svg',
              isActive: false,
            ),
            title: Text('ssdds'),
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
