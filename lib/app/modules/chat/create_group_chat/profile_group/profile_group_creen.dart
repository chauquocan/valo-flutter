import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import '../../chat_controller.dart';

class ProfileGroupScreen extends GetView<ChatController> {
  const ProfileGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(controller.avatar),
                  ))),
          SizedBox(
            height: 30,
          ),
          buildTextField("Name:    ", controller.name, Colors.lightBlue),
          buildTextField("View member   ", "", Colors.lightBlue),
          buildTextField("Leave group   ", "", Colors.red),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.lightBlue,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              labelText,
              style: TextStyle(fontSize: 20, color: color),
            ),
            SizedBox(width: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Group profile',
        style: TextStyle(color: AppColors.light),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
