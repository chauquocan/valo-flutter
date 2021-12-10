import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_binding.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_screen.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_menu.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import '../chat_controller.dart';

class ChatDetailScreen extends GetView<ChatController> {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          Get.isDarkMode ? Theme.of(context).backgroundColor : Colors.blue,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chat detail',
          style: TextStyle(color: AppColors.light),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
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
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      padding: const EdgeInsets.all(25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Get.isDarkMode
                          ? Colors.grey.shade900
                          : Color(0xFFF2F4FB),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontSize: 20,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.blue),
                        ),
                        const SizedBox(width: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            controller.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton(
                  color: Get.isDarkMode
                      ? Colors.grey.shade900
                      : const Color(0xFFF2F4FB),
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(5),
                  width: size.width,
                  elevation: 1,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.mms),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Media',
                            style: TextStyle(fontSize: 18),
                          )),
                      Expanded(flex: 1, child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                  onTap: () =>
                      Get.to(() => MediaScreen(), binding: MediaBinding()),
                )
              ]),
        ),
      ),
    );
  }
}
