import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ContactTab extends GetView<TabContactController> {
  const ContactTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'contact'.tr,
          style: TextStyle(color: AppColors.primary),
        ),
        backgroundColor: AppColors.light,
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Text('Contact'),
      ),
    );
  }
}
