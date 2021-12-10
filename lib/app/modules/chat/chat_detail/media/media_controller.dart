import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';

class MediaController extends GetxController {
  final chatController = Get.find<ChatController>();
  final chatProvider = Get.find<ChatProvider>();

  final _mediaMess = <MessageContent>[].obs;
  final _isLoading = false.obs;
  final _isMessLoaded = false.obs;
  final _page = 1.obs;

  List<MessageContent> get mediaMess => _mediaMess.value;

  set mediaMess(value) {
    _mediaMess.value = value;
  }

  bool get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  bool get isMessLoaded => _isMessLoaded.value;

  set isMessLoaded(value) {
    _isMessLoaded.value = value;
  }

  @override
  void onInit() {
    getMediaMessages('IMAGE');
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getMediaMessages(String type) async {
    isLoading = true;
    List<MessageContent> _messages = [];
    final response =
        await chatProvider.getMesagesByType(chatController.id, type, 0);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          _messages.add(content);
        }
        mediaMess.assignAll(_messages);
        isLoading = false;
      } else {
        isLoading = false;
      }
    } else {
      print(response);
    }
  }
}
