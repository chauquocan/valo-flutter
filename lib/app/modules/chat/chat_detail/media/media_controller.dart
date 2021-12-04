

import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';

class MediaController extends GetxController{
  final chatController = Get.find<ChatController>();

  final _mediaMess = <MessageContent>[].obs;
  final _isLoading = false.obs;
  final _isMessLoaded = false.obs;

  List<MessageContent> get mediaMess => _mediaMess.value;

  set mediaMess(value){
    _mediaMess.value=value;
  }

  bool get isLoading => _isLoading.value;

  set isLoading(value){
    _isLoading.value=value;
  }

  bool get isMessLoaded => _isMessLoaded.value;

  set isMessLoaded(value){
    _isMessLoaded.value=value;
  }


  @override
  void onInit() {
    // TODO: implement onInit
  getMediaMessages();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getMediaMessages()async{
    isLoading=true;
    List<MessageContent> temp = [];
    for (var mess in chatController.messages) {
      if(mess.message.messageType=='IMAGE'){
        temp.add(mess);
      }
    }
    mediaMess.assignAll(temp);
    isLoading=false;
  }
}