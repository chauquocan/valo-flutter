part of '../group.dart';

class AddMemberController extends GetxController {
  final chatController = Get.find<ChatController>();
  final contactController = Get.find<TabContactController>();
  final groupChatProvider = Get.find<GroupChatProvider>();
  final profileProvider = Get.find<ProfileProvider>();

  final _users = <User>[].obs;
  final _id = ''.obs;

  List<User> get users => _users;

  set users(value) {
    _users.value = value;
  }

  get id => _id.value;

  set id(value) {
    _id.value = value;
  }

  @override
  void onInit() {
    id = Get.arguments['conversationId'];
    getFriendsCanAddToGroup(id);
    super.onInit();
  }

  // add member
  Future addMember(userId, conversationId) async {
    final map = {'userId': userId, 'conversationId': conversationId};
    final response = await groupChatProvider.addMember(map);
    if (response.ok) {
      chatController.participants = response.data!.content;
      chatController.getMembers();
      customSnackbar().snackbarDialog('Sucessfully', 'Add member sucessfully');
    } else {
      customSnackbar()
          .snackbarDialog('Failed', 'Something wrong, please try again');
    }
  }

  // lấy ds bạn bè k có trong conversation
  Future getFriendsCanAddToGroup(String conversationId) async {
    final response =
        await groupChatProvider.getFriendsCanAddToGroup(conversationId);
    List<User> temp = [];
    for (var item in response.data!.content) {
      final user = await profileProvider.getUserById(item.friendId);
      temp.add(user.data!);
    }
    users.addAll(temp);
  }
}
