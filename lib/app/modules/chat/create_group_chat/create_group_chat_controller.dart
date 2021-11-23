import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class CreateGroupChatController extends GetxController {
  final chatController = Get.find<TabConversationController>();
  final ProfileProvider userProvider;
  final ContactProvider contactProvider;
  final GroupChatProvider groupChatProvider;

  TabContactController contactController = Get.find();

  CreateGroupChatController(
      {required this.userProvider,
      required this.contactProvider,
      required this.groupChatProvider});

  final textCtrl = TextEditingController();
  //
  final _name = ''.obs;
  final _participants = <Participants>[].obs;
  //
  final _isLoading = true.obs;
  final _users = <Profile>[].obs;
  final _selected = <Profile>[].obs;

  get name => _name.value;

  set name(value) {
    _name.value = value;
  }

  List<Participants> get participants => _participants;

  set participants(value) {
    _participants.value = value;
  }

  //
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

  // @override
  // void onInit() {
  //   getContacts();
  //   super.onInit();
  // }

//them minh la user dau tien
  @override
  void onInit() {
    // participants.add(Participants(
    //   userId: Storage.getUser()!.id,
    //   addByUserId: Storage.getUser()!.id,
    //   addTime: DateTime.now().toString(),
    //   admin: true,
    // ));
    getContacts();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onSelect(Profile item) {
    if (selected.contains(item)) {
      selected.removeWhere((element) => element == item);
    } else {
      selected.add(item);
    }
  }

  Future onSubmit() async {
    for (var content in selected) {
      participants.add(Participants(
        userId: content.id,
        addByUserId: Storage.getUser()!.id,
        addTime: DateTime.now().toString(),
        admin: false,
      ));
    }
    final map = {'name': textCtrl.text, 'participants': participants};
    final respones = await groupChatProvider.createGroupChat(map);
    if (respones.ok) {
      Get.back();
      chatController.getConversations();
    } else
      (print(respones));
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
