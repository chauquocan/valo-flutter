import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:valo_chat_app/app/data/models/contact_app.dart';

class TabContactController extends GetxController {
  final _contacts = <ContactModel>[].obs;
  final _contactsFiltered = <ContactModel>[].obs;
  final _contactsLoaded = false.obs;

  TextEditingController searchController = TextEditingController();

  get contactsLoaded => _contactsLoaded.value;

  set contactsLoaded(value) {
    _contactsLoaded.value = value;
  }

  List<ContactModel> get contacts => _contacts;

  set contacts(value) {
    _contacts.value = value;
  }

  List<ContactModel> get contactsFiltered => _contactsFiltered;

  set contactsFiltered(value) {
    _contactsFiltered.value = value;
  }

  @override
  void onInit() {
    getPermissions();
    super.onInit();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
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

    contacts = _contacts;
    contactsLoaded = true;
  }

  filterContacts() {
    List<ContactModel> contactsearch = [];
    contactsearch.addAll(_contacts);
    if (searchController.text.isNotEmpty) {
      contactsearch.retainWhere((_contact) {
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
    contactsFiltered = contactsearch;
  }
}
