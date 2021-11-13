import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class TabConversationController extends GetxController {
  final ChatProvider chatProvider;
  final ProfileProvider userProvider;

  TabConversationController({
    required this.chatProvider,
    required this.userProvider,
  });

  final isLoading = true.obs;
  final conversationsLoaded = false.obs;
  final conversations = <Conversation>[].obs;
  final userList = <Profile>[].obs;

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  /* 
    Get conversation
   */
  Future getConversations() async {
    conversations.value.clear();
    List<Conversation> _conversations = [];
    String currentUserId = Storage.getUser()!.id;
    final response = await chatProvider.GetConversations();
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var conversation in response.data!.content) {
          List<Participants> participants = conversation.participants;
          for (var participant in participants) {
            String userId = participant.userId;
            if (currentUserId != userId) {
              final user = await userProvider.getUserById(userId);
              _conversations.add(
                Conversation(
                  id: conversation.id,
                  name: user.data!.name,
                  avatar: user.data!.imgUrl,
                  time: '',
                  lastMessage: '',
                  isGroup: false,
                  createAt: conversation.createAt,
                  conversationType: conversation.conversationType,
                  participants: conversation.participants,
                ),
              );
            }
          }
        }
        conversations.value = _conversations;
        isLoading.value = false;
        conversationsLoaded.value = true;
        update();
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = true;
    }
  }
}
