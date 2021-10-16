import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class TabProfile extends GetView<TabProfileController> {
  const TabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'personal'.tr,
          style: TextStyle(color: AppColors.primary),
        ),
        backgroundColor: AppColors.light,
        actions: <Widget>[
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(
              Icons.login_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Text('profile'),
      ),
    );
  }
}
