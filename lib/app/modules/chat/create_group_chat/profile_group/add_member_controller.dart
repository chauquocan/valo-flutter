import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';

class AddMemberController extends GetxController {
  final chatController = Get.find<ChatController>();
  final GroupChatProvider groupChatProvider;
  final ProfileProvider profileProvider;

  final contactController = Get.find<TabContactController>();

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
    getContacts();
    print(users);
  }

///////// add member
  Future addMember(userId, conversationId) async {
    final map = {'userId': userId, 'conversationId': conversationId};
    final respones = await groupChatProvider.addMember(map);
    if (respones.ok) {
      Get.back();
    } else
      (print(respones));
  }

  // lấy ds bạn bè k có trong conversation    -- ko lay dc
  Future getContacts() async {
    contactController.getContactsFromAPI();
    //users.clear();
    for (var contact in contactController.contactId) {
      final user = await profileProvider.getUserById(contact.friendId);
      for (Profile content in chatController.members) {
        if (content.id != user.data!.id) {
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
    }
  }
}
