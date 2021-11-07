import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/contacts_list.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ContactTab extends StatefulWidget {
  const ContactTab({Key? key}) : super(key: key);

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  TabContactController controller = Get.find();
  @override
  Widget build(BuildContext context) {
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
        body: GetBuilder<TabContactController>(
          init: TabContactController(),
          builder: (TabContactController) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.functionPass();
                      } else {
                        controller.functionPass();
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Search',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor)),
                        prefixIcon: Icon(Icons.search,
                            color: Theme.of(context).primaryColor)),
                  ),
                ),
                Obx(() => controller.contactsLoaded.value
                    ? // if the contacts have not been loaded yet
                    // controller.isListItemsExist()
                    ((controller.searchController.text.isNotEmpty &&
                                controller.contactsFiltered.value.length > 0) ||
                            (!controller.searchController.text.isNotEmpty &&
                                controller.contacts.value.length > 0))
                        ? // if we have contacts to show
                        ContactsList(
                            reloadContacts: () {
                              controller.getAllContacts();
                            },
                            contacts: controller.isSearch.value
                                ? controller.contactsFiltered.value
                                : controller.contacts.value,
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              controller.isSearch.value
                                  ? 'No search results to show'
                                  : 'No contacts exist',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          )
                    : Container(
                        // still loading contacts
                        padding: EdgeInsets.only(top: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ))
              ],
            ),
          ),
        ));
  }
}







// body: Container(
//           child: Column(
//             children: [
//               ListView.builder(
//                 itemBuilder: (context, index) => CustomContact(
//                   contact: controller.contacts[index],
//                 ),
//                 itemCount: controller.contacts.length,
//               ),
//             ],
//           ),
//         ));