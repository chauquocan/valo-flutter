import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaController extends GetxController {
  final chatController = Get.find<ChatController>();
  final chatProvider = Get.find<ChatProvider>();
  final scrollController = ScrollController();

  final _mediaMess = <MessageContent>[].obs;
  final _listThumbnail = <String>[].obs;
  final _isLoading = false.obs;
  final _isMessLoaded = false.obs;
  final _page = 1.obs;

  final selectedType = 'IMAGE'.obs;
  List listType = ['IMAGE', 'VIDEO'];

  List<MessageContent> get mediaMess => _mediaMess.value;

  set mediaMess(value) {
    _mediaMess.value = value;
  }

  List<String> get listThumbnail => _listThumbnail.value;

  set listThumbnail(value) {
    _listThumbnail.value = value;
  }

  bool get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  bool get isMessLoaded => _isMessLoaded.value;

  set isMessLoaded(value) {
    _isMessLoaded.value = value;
  }

  int get page => _page.value;

  set page(value) {
    _page.value = value;
  }

  void setSelectedType(String value) {
    selectedType.value = value;
  }

  @override
  void onInit() {
    getMediaMessages();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  getMediaMessages() async {
    isLoading = true;
    List<MessageContent> _messages = [];
    final response = await chatProvider.getMesagesByType(
        chatController.id, selectedType.value, 0);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        print(response.data!.content);
        for (var content in response.data!.content) {
          _messages.add(content);
        }
        mediaMess = _messages;
        if (selectedType.value == "VIDEO") {
          await getThumbnail();
        }
        isLoading = false;
        isMessLoaded = true;
      } else {
        isLoading = false;
        isMessLoaded = false;
      }
    } else {
      isLoading = false;
      isMessLoaded = false;
    }
  }

  getMoreMediaMessages(int page) async {
    isLoading = true;
    List<MessageContent> _messages = [];
    final response = await chatProvider.getMesagesByType(
        chatController.id, selectedType.value, page);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          _messages.add(content);
        }
        mediaMess.addAll(_messages);
        isLoading = false;
        _page.value++;
      } else {
        isLoading = false;
      }
    } else {
      isLoading = false;
    }
  }

  Future<void> paginateMessages() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getMoreMediaMessages(_page.value);
        update();
      }
    });
  }

  Future<void> getThumbnail() async {
    List<String> _temp = [];
    for (var item in mediaMess) {
      if (item.message.content.isVideoFileName) {
        final fileName = await VideoThumbnail.thumbnailFile(
          video: item.message.content,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        );
        _temp.add(fileName.toString());
      }
    }
    listThumbnail = _temp;
  }
}
