import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/friend_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class TabContactController extends GetxController {
  final FriendProvider friendProvider;
  final UserProvider userProvider;

  TabContactController(
      {required this.friendProvider, required this.userProvider});
  //all contact list
  RxList<ContactModel> contacts = <ContactModel>[].obs;
  //fitlered contact list
  RxList<ContactModel> contactsFiltered = <ContactModel>[].obs;

  TextEditingController searchController = TextEditingController();
  final friendIdList = <ProfileResponse>[].obs;

  RxBool contactsLoaded = false.obs;

  final isSearch = false.obs;

  functionPass() {
    isSearch(!isSearch.value);
  }

  @override
  void onInit() {
    // getAllContacts();
    getContacts();
    super.onInit();
  }

  //Lay friend tu api
  Future getContacts() async {
    List<ContactModel> _contact = [];
    final response =
        await friendProvider.GetFriends(Storage.getToken()!.accessToken);
    if (response != null) {
      for (var i = 0; i < response.length; i++) {
        final user = await userProvider.getUserById(
            '${response[i].friendId}', Storage.getToken()!.accessToken);
        friendIdList.add(user.data!);
        _contact.add(ContactModel(
            id: user.data!.id, name: user.data!.name, phone: user.data!.phone));
      }
      contacts.value.addAll(_contact);
      contactsLoaded.value = true;
      update();
    } else {
      print('loi khi lay danh sach ban');
    }
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
    contacts.value.addAll(_contacts);
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
    contactsFiltered.value.addAll(contactSearch);
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
