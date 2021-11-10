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
  final conversationsLoaded = false.obs;
  final contentList = <Conversation>[].obs;
  final conversations = <ConversationCustom>[].obs;
  final userList = <ProfileResponse>[].obs;

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }
  
  Future getConversations() async {
    conversations.value.clear();
    List<ConversationCustom> _conversations = [];
    String currentUserId = Storage.getUser()!.id;
    final response = await chatProvider.GetConversations();
    print(response.data);
    if (response.ok) {
      for (var conversation in response.data!.content) {
        List<Participants> participants = conversation.participants;
        for (var participant in participants) {
          String userId = participant.userId;
          if (currentUserId != userId) {
            final user = await userProvider.getUserById(
                userId);
            _conversations.add(
              ConversationCustom(
                  name: user.data!.name,
                  icon: user.data!.imgUrl,
                  isGroup: false,
                  time: '',
                  currentMessage: ''),
            );
          }
        }
        conversations.value = _conversations;
        isLoading.value = false;
        conversationsLoaded.value = true;
        update();
      }
    } else {
      print('loi khi lay danh sach');
      isLoading.value = true;
    }
  }
}
