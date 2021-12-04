import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_menu.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

import '../chat_controller.dart';

class ChatDetailScreen extends GetView<ChatController> {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat detail',
          style: TextStyle(color: AppColors.light),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
          height: size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
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
                          backgroundImage:
                              CachedNetworkImageProvider(controller.avatar),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildTextField("Name:", controller.name, Colors.blue),
                  ProfileMenu(
                    text: "Media",
                    icon: "assets/icons/group.svg",
                    press: () {
                      // Get.to(() => MemberScreen());
                    },
                  ),
                ]),
          )),
    );
  }

  Widget buildTextField(String labelText, String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xFFF2F4FB),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              labelText,
              style: TextStyle(fontSize: 20, color: color),
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
}
