part of '../group.dart';


class CreateGroupChatController extends GetxController {
  final chatController = Get.find<TabConversationController>();
  final ProfileProvider userProvider;
  final ContactProvider contactProvider;
  final GroupChatProvider groupChatProvider;

  final contactController = Get.find<TabContactController>();

  CreateGroupChatController(
      {required this.userProvider,
      required this.contactProvider,
      required this.groupChatProvider});

  final textCtrl = TextEditingController();
  //
  final _name = ''.obs;
  final _participants = <Participant>[].obs;
  //
  final _isLoading = true.obs;
  final _users = <User>[].obs;
  final _selected = <User>[].obs;
  final nameFormKey = GlobalKey<FormState>();

  get name => _name.value;

  set name(value) {
    _name.value = value;
  }

  List<Participant> get participants => _participants;

  set participants(value) {
    _participants.value = value;
  }

  //
  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  List<User> get users => _users;

  set users(value) {
    _users.value = value;
  }

  List<User> get selected => _selected;

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
    textCtrl.dispose();
    super.onClose();
  }

  void onSelect(User item) {
    if (selected.contains(item)) {
      selected.removeWhere((element) => element == item);
    } else {
      selected.add(item);
    }
  }

  Future onSubmit() async {
    if (nameFormKey.currentState!.validate()) {
      for (var content in selected) {
        participants.add(Participant(
          userId: content.id,
          addByUserId: LocalStorage.getUser()!.id,
          addTime: DateTime.now().toString(),
          admin: false,
        ));
      }
      final map = {'name': textCtrl.text, 'participants': participants};
      final respones = await groupChatProvider.createGroupChat(map);

      if (respones.ok) {
        chatController.getConversations();
      } else
        print(respones);
    }
  }

  Future getContacts() async {
    contactController.getContactsFromAPI();
    for (var contact in contactController.contactId) {
      final user = await userProvider.getUserById(contact.friendId);
      users.add(user.data!);
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
