import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'body.dart';

//Profile tab view
class TabProfile extends GetView<TabProfileController> {
  const TabProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: WidgetAppBar(title: 'personal'.tr),
      body: Body(),
    );
  }
}
