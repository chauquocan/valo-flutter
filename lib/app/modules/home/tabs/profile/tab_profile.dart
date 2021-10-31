import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

import 'body.dart';

//Profile tab view
class TabProfile extends GetView<TabProfileController> {
  const TabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      //body view
      body: Body(),
    );
  }

  //app bar
  AppBar _appBar() {
    return AppBar(
      title: Text(
        'personal'.tr,
        style: TextStyle(color: AppColors.light),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
