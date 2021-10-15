import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';

class ContactTab extends GetView<TabContactController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Text('Contact'),
      ),
    );
  }
}
