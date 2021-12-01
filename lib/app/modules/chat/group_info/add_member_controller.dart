import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';

class AddMemberController extends GetxController {
  final chatController = Get.find<ChatController>();
  final contactController = Get.find<TabContactController>();

  final GroupChatProvider groupChatProvider;
  final ProfileProvider profileProvider;

  AddMemberController({
    required this.groupChatProvider,
    required this.profileProvider,
  });
  final _users = <Profile>[].obs;

  List<Profile> get users => _users;

  set users(value) {
    _users.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getContactsCanAllToGroup();
  }

///////// add member
  Future addMember(userId, conversationId) async {
    final map = {'userId': userId, 'conversationId': conversationId};
    final respones = await groupChatProvider.addMember(map);
    if (respones.ok) {
      Get.back();
    }
    print(respones);
  }

  // lấy ds bạn bè k có trong conversation    -- ko lay dc
  Future getContactsCanAllToGroup() async {
    List<Profile> temp = [];
    for (var contact in contactController.contactId) {
      final user = await profileProvider.getUserById(contact.friendId);
      temp.add(user.data!);
    }
    users = temp
        .where((element) => !chatController.members.contains(element.phone))
        .toList();
  }
}
