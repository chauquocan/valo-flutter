import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/conversation.dart';

class TabConversationController extends GetxController {
  final isLoading = false.obs;
  final conversations = <ConversationModel>[].obs;
}
