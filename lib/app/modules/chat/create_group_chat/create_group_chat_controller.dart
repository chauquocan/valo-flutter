import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class CreateGroupChatController extends GetxController {
  final UserProvider userProvider;

  CreateGroupChatController({
    required this.userProvider,
  });

  final textCtrl = TextEditingController();

  final _isLoading = true.obs;
  final _users = <ProfileResponse>[].obs;
  final _selected = <ProfileResponse>[].obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  List<ProfileResponse> get users => _users;

  set users(value) {
    _users.value = value;
  }

  List<ProfileResponse> get selected => _selected;

  set selected(value) {
    _selected.value = value;
  }

  @override
  void onInit() {
    getAllUser();
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

  void onSelect(ProfileResponse item) {
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

  // lay all user //userProvider.getAllUser
  Future getAllUser() async {
    final getAllResponse = await userProvider.getAllUser(
      Storage.getToken()!.accessToken,
    );
    if (getAllResponse != null) {
      users.addAll(getAllResponse);
      print(users.toString());
    } else {
      Get.snackbar('Search failed', 'Something wrong');
    }
  }
}
