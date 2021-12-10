import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/contacts_list.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import 'import_contact/import_contact_binding.dart';
import 'import_contact/import_contact_screen.dart';

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
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: WidgetAppBar(
            title: 'contact'.tr,
            blackButton: false,
          ),
          floatingActionButton: FloatingActionButton(
              heroTag: 'btnContact',
              onPressed: () {
                Get.toNamed('/newfriend');
              },
              child:
                  Tooltip(message: 'Thêm bạn', child: Icon(Icons.person_add))),
          body: GetBuilder<TabContactController>(
            builder: (_) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          tileColor: Get.isDarkMode
                              ? Colors.grey.shade900
                              : Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          leading: const CircleAvatar(
                            radius: 30,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(29)),
                              child: Icon(Icons.person_add_alt),
                            ),
                          ),
                          title: Text('Cập nhật danh bạ'),
                          onTap: () => Get.to(() => ImportContactScreen(),
                              binding: ImportContactBinding()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                          tileColor: Get.isDarkMode
                              ? Colors.grey.shade900
                              : Colors.white,
                          contentPadding: EdgeInsets.all(10),
                          leading: const CircleAvatar(
                            radius: 30,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(29)),
                              child: Icon(Icons.three_p),
                            ),
                          ),
                          title: Text('Lời mời kết bạn'),
                          onTap: () => Get.toNamed('/friendrequest'),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Danh bạ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => controller.contactsLoaded.value
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
                          ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
