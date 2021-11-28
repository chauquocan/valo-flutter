import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_info.dart';

import './widgets/profile_menu.dart';

//profile's body view
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TabProfileController>();
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ProfileInforWidget(),
            SizedBox(height: 10),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () => Get.toNamed('/setting'),
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                Get.dialog(
                  AlertDialog(
                    title: Center(child: Text('Lưu ý')),
                    content: SingleChildScrollView(
                      child: Text('Bạn có chắc chắn muốn thoát?'),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                          controller.logout();
                        },
                        icon: Icon(Icons.check_circle),
                        // style: ButtonStyle(backgroundColor: Colors.blue),
                        label: Text(
                          "Xác nhận",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.cancel),
                        // style: ButtonStyle(backgroundColor: Colors.blue),
                        label: Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
