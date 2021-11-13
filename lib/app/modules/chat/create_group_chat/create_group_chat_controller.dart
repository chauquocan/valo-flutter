import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';

class CreateGroupChatController extends GetxController {
  final ProfileProvider userProvider;
  final ContactProvider contactProvider;

  TabContactController contactController = Get.find();

  CreateGroupChatController({
    required this.userProvider,
    required this.contactProvider,
  });

  final textCtrl = TextEditingController();

  final _isLoading = true.obs;
  final _users = <Profile>[].obs;
  final _selected = <Profile>[].obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  List<Profile> get users => _users;

  set users(value) {
    _users.value = value;
  }

  List<Profile> get selected => _selected;

  set selected(value) {
    _selected.value = value;
  }

  @override
  void onInit() {
    getContacts();
    super.onInit();
  }

// them minh la user dau tien
// @override
//   void onInit() async {
//     users = await userProvider.getUsers();
//     selected.add(MyUser(
//         uid: UserProvider.getCurrentUser().uid,
//         avatar: UserProvider.getCurrentUser().photoURL,
//         name: 'You',
//         email: UserProvider.getCurrentUser().email ?? '',
//         isActive: false));
//     isLoading = false;
//     super.onInit();
//   }

  void onSelect(Profile item) {
    if (selected.contains(item)) {
      selected.removeWhere((element) => element == item);
    } else {
      selected.add(item);
    }
  }

  Future onSubmit() async {
    // await provider.createGroupChat(
    //   selected.map((e) => e.uid).toList(),
    //   textCtrl.text,
    // );
    Get.back();
  }

  Future getContacts() async {
    contactController.getContactsFromAPI();
    for (var contact in contactController.contactId) {
      final user = await userProvider.getUserById(contact.friendId);
      users.add(
        Profile(
            id: user.data!.id,
            name: user.data!.name,
            gender: user.data!.gender,
            dateOfBirth: user.data!.dateOfBirth,
            phone: user.data!.phone,
            email: user.data!.email,
            address: user.data!.address,
            imgUrl: user.data!.imgUrl,
            status: user.data!.status),
      );
    }
  }

  // lay all user //userProvider.getAllUser
  // Future getAllUser() async {
  //   final response = await userProvider.getAllUser(
  //     Storage.getToken()!.accessToken,
  //   );
  //   if (response.ok) {
  //     users.addAll(response.data!);
  //     print(users.toString());
  //   } else {
  //     Get.snackbar('Search failed', 'Something wrong');
  //   }
  // }
}
