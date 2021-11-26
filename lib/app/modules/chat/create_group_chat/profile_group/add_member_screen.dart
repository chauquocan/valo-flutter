import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widget_appbar.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import '../create_group_chat_controller.dart';

class AddMemberScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.users.length,
          itemBuilder: (context, i) {
            final users = controller.users[i];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onLongPress: () {},
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                  backgroundImage: NetworkImage('${users.imgUrl}'),
                ),
                title: Text(
                  users.name,
                  style: TextStyle(fontSize: 18),
                ),
                trailing: IconButton(
                  onPressed: () {
                    controller.addMember(users.id, controller.id);
                    Get.back();
                    Get.back();
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ),
            );
          },
        ));
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Add new member',
      style: TextStyle(color: AppColors.light),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
