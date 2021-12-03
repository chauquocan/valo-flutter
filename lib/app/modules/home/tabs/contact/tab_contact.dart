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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('/newfriend');
                },
                icon: const Icon(Icons.person_add),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.contacts),
              ),
            ],
          ),
          body: GetBuilder<TabContactController>(
            builder: (_) => Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
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
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            child:
                                Image.asset('assets/images/place_avatar.png'),
                          ),
                          title: Text('Cập nhật danh bạ'),
                        ),
                      ],
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
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(
                                controller.isSearch.value
                                    ? 'No search results to show'
                                    : 'No contacts exist',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 20),
                              ),
                            )
                      : Container(
                          // still loading contacts
                          padding: const EdgeInsets.only(top: 40),
                          child: const Center(
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
