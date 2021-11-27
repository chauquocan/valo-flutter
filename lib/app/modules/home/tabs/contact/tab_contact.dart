import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/contacts_list.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';

class ContactTab extends StatefulWidget {
  const ContactTab({Key? key}) : super(key: key);

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  TabContactController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('contact'.tr),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('/newfriend');
                },
                icon: Icon(Icons.person_add),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.contacts),
              ),
            ],
          ),
          body: GetBuilder<TabContactController>(
            builder: (_) => Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.isSearch(true);
                        } else {
                          controller.isSearch(false);
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Phone number, name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          suffixIcon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  Obx(() => controller.contactsLoaded.value
                      ? // if the contacts have not been loaded yet
                      ((controller.searchController.text.isNotEmpty &&
                                  controller.contactsFiltered.length > 0) ||
                              (!controller.searchController.text.isNotEmpty &&
                                  controller.contacts.length > 0))
                          ? // if we have contacts to show
                          ContactsList(
                              contacts: controller.isSearch.value
                                  ? controller.contactsFiltered
                                  : controller.contacts,
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
                            child: Text('No contacts'),
                          ),
                        ))
                ],
              ),
            ),
          )),
    );
  }
}
