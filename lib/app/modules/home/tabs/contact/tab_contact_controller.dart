import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:contacts_service/contacts_service.dart';

class TabContactController extends GetxController {
  //all contact list
  RxList<ContactModel> contacts = <ContactModel>[].obs;
  //fitlered contact list
  RxList<ContactModel> contactsFiltered = <ContactModel>[].obs;

  TextEditingController searchController = TextEditingController();

  RxBool contactsLoaded = false.obs;

  final isSearch = false.obs;

  functionPass() {
    isSearch(!isSearch.value);
  }

  @override
  void onInit() {
    super.onInit();
    getPermissions();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() => filterContacts());
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

// lay contact tu dt
  getAllContacts() async {
    List<ContactModel> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      return ContactModel(
          name: contact.displayName, phone: contact.phones!.elementAt(0).value);
    }).toList();
    contacts.value = _contacts;
    // contacts.assignAll(_contacts);
    contactsLoaded.value = true;
  }

  filterContacts() async {
    List<ContactModel> contactSearch = [];
    contactSearch.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      contactSearch.retainWhere((_contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = _contact.name!.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);

        if (nameMatches == true) {
          return true;
        }
        if (searchTermFlatten.isEmpty) {
          return false;
        }

        String phnFlattened = _contact.phone!.toLowerCase();
        return phnFlattened.contains(searchTermFlatten);
      });
    }
    contactsFiltered.value = contactSearch;
    // contactsFiltered.assignAll(contactSearch);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
