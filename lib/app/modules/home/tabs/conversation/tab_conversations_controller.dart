import 'package:get/get.dart';

import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class TabConversationController extends GetxController {
  final ChatProvider chatProvider;
  final UserProvider userProvider;

  TabConversationController({
    required this.chatProvider,
    required this.userProvider,
  });

  final isLoading = true.obs;
  final contentList = <ConversationContent>[].obs;
  final conversations = <ConversationModel>[].obs;
  final userList = <ProfileResponse>[].obs;

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   getConversations();
  //   super.onInit();
  // }

  Future getConversations() async {
    conversations.value.clear();
    List<ConversationModel> _conversations = [];
    String currentUserId = Storage.getUser()!.id;
    final response =
        await chatProvider.GetConversations(Storage.getToken()!.accessToken);
    if (response != null) {
      for (var i = 0; i < response.length; i++) {
        List<Participants> participants = response[i].participants;
        for (var j = 0; j < participants.length; j++) {
          String userId = participants[j].userId;
          if (currentUserId != userId) {
            final user = await userProvider.getUserById(
                userId, Storage.getToken()!.accessToken);
            _conversations.add(ConversationModel(
                name: user.data!.name,
                icon: user.data!.imgUrl,
                isGroup: false,
                time: '',
                currentMessage: ''));
          }
        }
      }
      conversations.value.addAll(_conversations);
      isLoading.value = false;
      update();
    } else {
      print('loi khi lay danh sach');
      isLoading.value = true;
    }
  }
}
