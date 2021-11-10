import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:valo_chat_app/app/data/models/contact_model.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';

class TabContactController extends GetxController {
  final ContactProvider friendProvider;
  final UserProvider userProvider;
  final searchController = TextEditingController();

  TabContactController(
      {required this.friendProvider, required this.userProvider});

  //all contact list
  final _contacts = <ContactCustom>[].obs;
  //fitlered contact list
  final _contactsFiltered = <ContactCustom>[].obs;

  final _contactsLoaded = false.obs;
  final _isSearch = false.obs;

  List<ContactCustom> get contacts => _contacts.value;
  set contacts(value) {
    _contacts.value = value;
  }

  List<ContactCustom> get contactsFiltered => _contactsFiltered.value;
  void setContactsFiltered(value) {
    _contactsFiltered.value = value;
  }

  get contactsLoaded => _contactsLoaded.value;
  SetContactsLoaded(value) {
    _contactsLoaded.value = value;
  }

  get isSearch => _isSearch.value;
  setIsSearch(value) {
    _isSearch.value = value;
  }

  @override
  void onInit() {
    getContactsFromAPI();
    super.onInit();
  }

  //Lay friend tu api
  Future getContactsFromAPI() async {
    List<ContactCustom> _contactsTemp = [];
    final response = await friendProvider.getFriends();
    if (response.ok) {
      for (var contact in response.data!.content) {
        final user = await userProvider.getUserById(contact.friendId);
        _contactsTemp.add(ContactCustom(
            id: user.data!.id, name: user.data!.name, phone: user.data!.phone));
      }
      _contacts.value = _contactsTemp;
      _contactsLoaded.value = true;
      getContactsFromPhone();
      update();
    } else {
      print('loi khi lay danh sach ban');
    }
  }

  //get contactInfo
  Future<ProfileResponse?> getContact(String id) async {
    final user = await userProvider.getUserById(id);
    return user.data;
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getContactsFromPhone();
      searchController.addListener(() => filterContacts());
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

// lay contact tu dt
  getContactsFromPhone() async {
    List<ContactCustom> _contactsTemp =
        (await ContactsService.getContacts()).map((contact) {
      return ContactCustom(
          name: contact.displayName, phone: contact.phones!.elementAt(0).value);
    }).toList();
    _contacts.value.addAll(_contactsTemp);
    _contactsLoaded.value = true;
    update();
  }

  filterContacts() async {
    List<ContactCustom> contactSearch = [];
    contactSearch.addAll(_contacts);
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
    _contactsFiltered.value = contactSearch;
    update();
  }

  @override
  void onClose() {
    searchController.clear();
    super.onClose();
  }
}
