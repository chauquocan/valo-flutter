import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

import 'body.dart';

class TabProfile extends GetView<TabProfileController> {
  const TabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // actions: <Widget>[
      //   IconButton(
      //     // chuyen nut nay thanh nut back
      //     onPressed: () => Get.back(),
      //     icon: Icon(Icons.arrow_back),
      //     color: AppColors.light,
      //   ),
      // ],
      title: Text(
        'personal'.tr,
        style: TextStyle(color: AppColors.light),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
