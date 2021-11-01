import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/custom_contact.dart';

class ContactTab extends GetView<TabContactController> {
  const ContactTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'contact'.tr,
            style: TextStyle(color: AppColors.light),
          ),
          backgroundColor: Colors.lightBlue,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Get.toNamed('/newfriend');
                },
                icon: Icon(Icons.person_add))
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => CustomContact(
            contact: controller.contacts[index],
          ),
          itemCount: controller.contacts.length,
        ));
  }
}
