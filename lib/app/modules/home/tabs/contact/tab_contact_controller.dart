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
  // late RxBool isSearching = true.obs;

  late RxBool listItemsExist =
      ((isSearching() && contactsFiltered.value.length > 0) ||
              (!isSearching() && contacts.value.length > 0))
          .obs;
  final searchController = TextEditingController();

  bool isSearching() {
    if (searchController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    print(isSearching());
    getPermissions();
    super.onInit();
  }

  Future getPermissions() async {
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
    contacts.value = _contacts;
    contactsLoaded.value = true;
    update();
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
    update();
  }

  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   searchController.addListener(() {
  //     filterContacts();
  //   });
  //   super.onReady();
  // }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
