import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_chat_app/app/data/models/contact_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';

class TabContactController extends GetxController {
  final ContactProvider contactProvider;
  final ProfileProvider userProvider;
  final searchController = TextEditingController();

  TabContactController(
      {required this.contactProvider, required this.userProvider});

  //all contact list
  final contacts = <ContactCustom>[].obs;
  //fitlered contact list
  final contactsFiltered = <ContactCustom>[].obs;
  final contactId = <ContactContent>[].obs;
  final contactsLoaded = false.obs;
  final isSearch = false.obs;
  final isImported = false.obs;
  final _page = 0.obs;

  functionPass() {
    isSearch(!isSearch.value);
  }

  @override
  void onInit() {
    getContactsFromAPI();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.clear();
    super.onClose();
  }

  /* 
    Get contacts from api
   */
  Future getContactsFromAPI() async {
    List<ContactCustom> _contactsTemp = [];
    final response = await contactProvider.getFriends(_page.value);
    if (response.ok) {
      contactId.value = response.data!.content;
      for (var contact in response.data!.content) {
        final user = await userProvider.getUserById(contact.friendId);
        _contactsTemp.add(ContactCustom(
            id: user.data!.id,
            name: user.data!.name,
            phone: user.data!.phone,
            imgUrl: user.data!.imgUrl));
      }
      contacts.value = _contactsTemp;
      contactsLoaded.value = true;
      searchController.addListener(() => filterContacts());
      getPermissions();
      update();
    } else {
      print('loi khi lay danh sach ban');
    }
  }

  // Future getMoreContactAPI() async {
  //   List<ContactCustom> _contactsTemp = [];
  //   final response = await contactProvider.getFriends(_page.value);
  //   if (response.ok) {
  //     contactId.value = response.data!.content;
  //     for (var contact in response.data!.content) {
  //       final user = await userProvider.getUserById(contact.friendId);
  //       _contactsTemp.add(ContactCustom(
  //           id: user.data!.id,
  //           name: user.data!.name,
  //           phone: user.data!.phone,
  //           imgUrl: user.data!.imgUrl));
  //     }
  //     contacts.value = _contactsTemp;
  //     contactsLoaded.value = true;
  //     searchController.addListener(() => filterContacts());
  //     getPermissions();
  //   } else {
  //     print('loi khi lay danh sach ban');
  //   }
  // }

  /* 
    Get contact info from id
   */
  Future<User?> getContact(String id) async {
    final user = await userProvider.getUserById(id);
    return user.data;
  }

  /* Get permission to read/write contact */
  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      // getContactsFromPhone();
      searchController.addListener(() => filterContacts());
      isImported.value = true;
    }
  }

  /*  */
  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  /* 
    Get contacts from phone
    Unfinished
    Need update get contacts and send to api
    and compare to those who have signed to app
   */
  getContactsFromPhone() async {
    List<ContactCustom> _contactsTemp =
        (await ContactsService.getContacts()).map((contact) {
      return ContactCustom(
          name: contact.displayName, phone: contact.phones!.elementAt(0).value);
    }).toList();
    contacts.value.addAll(_contactsTemp);
    contactsLoaded.value = true;
  }

  /* 
    Filtered contacts from search
  */
  filterContacts() async {
    List<ContactCustom> contactSearch = [];
    contactSearch.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      contactSearch.retainWhere(
        (_contact) {
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
        },
      );
    }
    contactsFiltered.value = contactSearch;
    update();
  }
}
