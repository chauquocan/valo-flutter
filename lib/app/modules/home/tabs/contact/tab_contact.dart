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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          isExtended: true,
          onPressed: () => controller.getPermissions(),
        ),
        body: GetBuilder<TabContactController>(
          // init: TabContactController(),
          builder: (TabContactController) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.setIsSearch(true);
                      } else {
                        controller.setIsSearch(false);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        prefixIcon: Icon(Icons.search,
                            color: Theme.of(context).primaryColor)),
                  ),
                ),
                Obx(() => controller.contactsLoaded
                    ? // if the contacts have not been loaded yet
                    ((controller.searchController.text.isNotEmpty &&
                                controller.contactsFiltered.length > 0) ||
                            (controller.searchController.text.isEmpty &&
                                controller.contacts.length > 0))
                        ? // if we have contacts to show
                        ContactsList(
                            reloadContacts: () {
                              controller.getContactsFromPhone();
                            },
                            contacts: controller.isSearch
                                ? controller.contactsFiltered
                                : controller.contacts,
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              controller.isSearch
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
                          child: Text('No contacts'),
                        ),
                      ))
              ],
            ),
          ),
        ));
  }
}
