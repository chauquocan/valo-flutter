import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:valo_chat_app/app/data/models/contact_app.dart';

class TabContactController extends GetxController {
  final contacts = <ContactModel>[].obs;
  final contactsFiltered = <ContactModel>[].obs;
  final contactsLoaded = false.obs;

  late final isSearching = searchController.text.isNotEmpty.obs;
  late final listItemsExist =
      ((isSearching == true && contactsFiltered.value.length > 0) ||
              (isSearching != true && contacts.value.length > 0))
          .obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    getPermissions();
    super.onInit();
  }

  Future getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      // searchController.addListener(() {
      //   filterContacts();
      // },
      // );
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

// lay contact tu dt
  Future getAllContacts() async {
    List<ContactModel> _contacts =
        (await ContactsService.getContacts()).map((contact) {
      return ContactModel(
          name: contact.displayName, phone: contact.phones!.elementAt(0).value);
    }).toList();
    contacts.value = _contacts;
    contactsLoaded.value = true;
  }

  filterContacts() {
    List<ContactModel> contactSearch = [];
    contactSearch.addAll(contacts.value);
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
  }

  @override
  void onReady() {
    // TODO: implement onReady
    searchController.addListener(() {
      filterContacts();
    });
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
