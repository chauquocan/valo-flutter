part of '../group.dart';

class CreateGroupChatController extends GetxController {
  final chatController = Get.find<TabConversationController>();
  final userProvider = Get.find<ProfileProvider>();
  final contactProvider = Get.find<ContactProvider>();
  final groupChatProvider = Get.find<GroupChatProvider>();

  final contactController = Get.find<TabContactController>();

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

//them minh la user dau tien
  @override
  void onInit() {
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
        customSnackbar()
            .snackbarDialog('Successfully', 'Create group successfully');
        chatController.getConversations();
        Get.offAllNamed('/home');
      } else {
        customSnackbar()
            .snackbarDialog('Failed', 'Something wrong, please try again');
      }
    }
  }

  Future getContacts() async {
    contactController.getContactsFromAPI();
    for (var contact in contactController.contactId) {
      final user = await userProvider.getUserById(contact.friendId);
      users.add(user.data!);
    }
  }
}
