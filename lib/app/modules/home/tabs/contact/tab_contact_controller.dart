import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/contact_model.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';

class TabContactController extends GetxController {
  final contactProvider = Get.find<ContactProvider>();
  final userProvider = Get.find<ProfileProvider>();

  final searchController = TextEditingController();

  //all contact list
  final contacts = <UserContent>[].obs;
  //fitlered contact list
  final contactsFiltered = <UserContent>[].obs;
  final contactId = <ContactContent>[].obs;

  final contactsLoaded = false.obs;
  final isSearch = false.obs;
  final _page = 0.obs;

  changeSearchStatus() {
    isSearch(!isSearch.value);
  }

  @override
  void onInit() {
    getContactsFromAPI();
    super.onInit();
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
    List<UserContent> _contactsTemp = [];
    final response = await contactProvider.getFriends(0);
    if (response.ok) {
      contactId.value = response.data!.content;
      for (var contact in response.data!.content) {
        final user = await userProvider.getUserById(contact.friendId);
        _contactsTemp.add(UserContent(user: user.data!, friend: true));
      }
      contacts.value = _contactsTemp;
      contactsLoaded.value = true;
      searchController.addListener(() => filterContacts());
    } else {
      contactsLoaded.value = false;
    }
  }

  Future getMoreContactAPI() async {
    List<UserContent> _contactsTemp = [];
    final response = await contactProvider.getFriends(_page.value);
    if (response.ok) {
      contactId.value = response.data!.content;
      for (var contact in response.data!.content) {
        final user = await userProvider.getUserById(contact.friendId);
        _contactsTemp.add(UserContent(user: user.data!, friend: true));
      }
      contacts.value = _contactsTemp;
      contactsLoaded.value = true;
    } else {
      contactsLoaded.value = false;
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
  // getContactsFromPhone() async {
  //   List<ContactCustom> _contactsTemp =
  //       (await ContactsService.getContacts()).map((contact) {
  //     return ContactCustom(
  //         name: contact.displayName, phone: contact.phones!.elementAt(0).value);
  //   }).toList();
  //   contacts.value.addAll(_contactsTemp);
  //   contactsLoaded.value = true;
  // }

  /* 
    Filtered contacts from search
  */
  filterContacts() async {
    List<UserContent> contactSearch = [];
    contactSearch.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      contactSearch.retainWhere(
        (_contact) {
          String searchTerm = searchController.text.toLowerCase();
          String searchTermFlatten = flattenPhoneNumber(searchTerm);
          String contactName = _contact.user.name.toLowerCase();
          bool nameMatches = contactName.contains(searchTerm);
          if (nameMatches == true) {
            return true;
          }

          if (searchTermFlatten.isEmpty) {
            return false;
          }

          String phnFlattened = _contact.user.phone.toLowerCase();
          return phnFlattened.contains(searchTermFlatten);
        },
      );
    }
    contactsFiltered.value = contactSearch;
  }
}
