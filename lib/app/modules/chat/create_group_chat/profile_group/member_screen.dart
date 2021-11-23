import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

import '../../chat_controller.dart';

class MemberScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: ListView.builder(
          itemCount: controller.members.length,
          itemBuilder: (context, i) {
            final member = controller.members[i];
            return ListTile(
              onLongPress: () {},
              onTap: () {},
              leading: Hero(
                  tag: member.id,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 30,
                    backgroundImage: NetworkImage('${member.imgUrl}'),
                  )),
              title: Text(
                "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
        ));
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      'Group member',
      style: TextStyle(color: AppColors.light),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
