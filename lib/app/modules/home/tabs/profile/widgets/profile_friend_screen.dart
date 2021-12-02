import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ProfileFriendScreen extends GetView<ChatController> {
  const ProfileFriendScreen({Key? key}) : super(key: key);

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
          const SizedBox(
            height: 30,
          ),
          buildTextField("Name:    ", controller.name),
          buildTextField("Phone:   ", "0772555445"),
          buildTextField("E-mail:   ", "S2taaa@gmail.com"),
          buildTextField("Address:", "Gia Nghia"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                color: Colors.red[400],
                padding: EdgeInsets.symmetric(horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: const Text(
                  "Block",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.lightBlue,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(fontSize: 20, color: Colors.black38),
            ),
            const SizedBox(width: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Friend Profile',
        style: TextStyle(color: AppColors.light),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
