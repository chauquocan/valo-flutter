import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/models/message.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/utils/stomp_service.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ChatController extends GetxController {
  final ChatProvider provider;

  ChatController({
    required this.provider,
  });

  final textController = TextEditingController();
  final keyboardController = KeyboardVisibilityController();
  final scrollController = ScrollController();

  final _id = ''.obs;
  final _name = ''.obs;
  final _deviceToken = <dynamic>[].obs;
  final _fromContact = false.obs;
  final _emojiShowing = false.obs;
  final _stickerShowing = false.obs;
  final _showMore = false.obs;
  final _isKeyboardVisible = false.obs;
  final _messages = <MessageModel>[].obs;
  final _isLoading = true.obs;

  get showMore => _showMore.value;

  set showMore(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
    _showMore.value = value;
  }

  /*------------------------*/
  // Socketchannel
  @override
  void onInit() {
    super.onInit();
    // provider.stompClient.activate();
    StompService().startStomp();
    // provider.connectChannel();
    print('socket client running');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    StompService().desTroyStomp();
    // provider.channel.sink.close();
  }

  /*------------------------*/
  final _tagging = false.obs;
  final _members = <ProfileResponse>[].obs;
  final _listTagged = <ProfileResponse>[].obs;

  get id => _id.value;

  set id(value) {
    _id.value = value;
  }

  get name => _name.value;

  set name(value) {
    _name.value = value;
  }

  get deviceToken => _deviceToken;

  set deviceToken(value) {
    _deviceToken.value = value;
  }

  get fromContact => _fromContact.value;

  set fromContact(value) {
    _fromContact.value = value;
  }

  get emojiShowing => _emojiShowing.value;

  set emojiShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && stickerShowing) {
      stickerShowing = false;
    }
    _emojiShowing.value = value;
  }

  get stickerShowing => _stickerShowing.value;

  set stickerShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && emojiShowing) {
      emojiShowing = false;
    }
    _stickerShowing.value = value;
  }

  get isKeyboardVisible => _isKeyboardVisible.value;

  set isKeyboardVisible(value) {
    _isKeyboardVisible.value = value;
  }

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  List<MessageModel> get messages => _messages;

  set messages(value) {
    _messages.value = value;
  }

  get tagging => _tagging.value;

  set tagging(value) {
    _tagging.value = value;
  }

  List<ProfileResponse> get members => _members;

  List<ProfileResponse> get membersWithoutMe =>
      _members.where((element) => element.id != Storage.getUser()?.id).toList();

  set members(value) {
    _members.value = value;
  }

  List<ProfileResponse> get listTagged => _listTagged;

  set listTagged(value) {
    _listTagged.value = value;
  }

  // @override
  // void onInit() async {
  //   id = Get.arguments['uID'];
  //   name = Get.arguments['name'];
  //   fromContact = Get.arguments['isFromContact'];
  //   deviceToken = Get.arguments['deviceToken'];
  //   members = List<ProfileResponse>.from(Get.arguments['members']);
  //   /*-----------------------------------------------*/
  //   textController.addListener(() {
  //     textController.text.split(' ').forEach((e) {
  //       if (e.startsWith('@')) {
  //         tagging = true;
  //       } else {
  //         tagging = false;
  //       }
  //     });
  //   });
  //   if (fromContact) {
  //     provider.getMessagesFromContact(id)
  //       ..listen((event) {}).onData((data) {
  //         messages = data;
  //         isLoading = false;
  //       });
  //   } else {
  //     provider.getMessages(id)
  //       ..listen((event) {}).onData((data) {
  //         messages = data;
  //         isLoading = false;
  //       });
  //   }

  //   var keyboardVisibilityController = KeyboardVisibilityController();
  //   keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
  //     this.isKeyboardVisible = isKeyboardVisible;
  //     if (isKeyboardVisible && emojiShowing) {
  //       emojiShowing = false;
  //     } else if (isKeyboardVisible && stickerShowing) {
  //       stickerShowing = false;
  //     } else if (isKeyboardVisible && showMore) {
  //       showMore = false;
  //     }
  //   });
  //   super.onInit();
  // }

  // void onTagSelect(ProfileResponse user) {
  //   tagging = !tagging;
  //   textController.text += user.name;
  //   listTagged.add(user);
  //   _moveCursorToLast();
  // }

  void sendMessage() {
    if (textController.text.isNotEmpty) {
      StompService.stompClient.send(
          destination: "/app/chat",
          body: json.encode({
            "replyId": Storage.getUser()!.id,
            "conversationId": "fsdfsdf",
            "messageType": "TEXT",
            "content": '${textController.text}'
          }));
      // provider.channel.sink.add(textController.text);
      // textController.
    }
    // if (textController.text.isNotEmpty) {
    //   // TODO(ff3105): need to optimize
    //   if (listTagged.isNotEmpty) {
    //     for (var value in listTagged) {
    //       ntfProvider.pushNotifyToPeer(
    //           name,
    //           UserProvider.getCurrentUser().displayName! + ' has mention you',
    //           UserProvider.getCurrentUser().uid,
    //           value.deviceToken ?? []);
    //     }
    //   }

    //   final message = Message(
    //     senderUID: UserProvider.getCurrentUser().uid,
    //     senderName: UserProvider.getCurrentUser().displayName!,
    //     senderAvatar: UserProvider.getCurrentUser().photoURL,
    //     message: textController.text,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     type: 0,
    //   );
    //   if (fromContact) {
    //     provider.sendMessageFromContact(id, message);
    //     ntfProvider.pushNotifyToPeer(
    //         UserProvider.getCurrentUser().displayName!,
    //         textController.text,
    //         UserProvider.getCurrentUser().uid,
    //         deviceToken ?? []);
    //   } else {
    //     provider.sendMessage(id, message);
    //     ntfProvider.pushNotifyToPeer(
    //         name,
    //         UserProvider.getCurrentUser().displayName! +
    //             ': ${textController.text}',
    //         UserProvider.getCurrentUser().uid,
    //         deviceToken ?? []);
    //   }
    //   textController.clear();
    //   if (messages.length >= 1) {
    //     scrollController.animateTo(0,
    //         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    //   }
    // }
  }

  void sendSticker(String? url) {
    // final message = Message(
    //     senderUID: UserProvider.getCurrentUser().uid,
    //     senderName: UserProvider.getCurrentUser().displayName!,
    //     senderAvatar: UserProvider.getCurrentUser().photoURL,
    //     message: url!,
    //     createdAt: DateTime.now().millisecondsSinceEpoch,
    //     type: 2);
    // if (fromContact) {
    //   provider.sendMessageFromContact(id, message);
    //   ntfProvider.pushNotifyToPeer(
    //       UserProvider.getCurrentUser().displayName!,
    //       UserProvider.getCurrentUser().displayName! + ' send a sticker',
    //       UserProvider.getCurrentUser().uid,
    //       deviceToken ?? []);
    // } else {
    //   provider.sendMessage(id, message);
    //   ntfProvider.pushNotifyToPeer(
    //       name,
    //       UserProvider.getCurrentUser().displayName! + ' send a sticker ',
    //       UserProvider.getCurrentUser().uid,
    //       deviceToken ?? []);
    // }
  }

  void onEmojiSelected(Emoji emoji) {
    textController.text += emoji.emoji;
    _moveCursorToLast();
  }

  void onBackspacePressed() {
    textController.text = textController.text.characters.skipLast(1).string;
    _moveCursorToLast();
  }

  void toggleEmojiKeyboard() {
    if (isKeyboardVisible) {
      FocusScope.of(Get.context!).unfocus();
    }
  }

  Future<bool> onBackPress() {
    if (emojiShowing) {
      toggleEmojiKeyboard();
      emojiShowing = !emojiShowing;
    } else if (stickerShowing) {
      toggleEmojiKeyboard();
      stickerShowing = !stickerShowing;
    } else {
      Navigator.pop(Get.context!);
    }
    return Future.value(false);
  }

  Future sendImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile;
    pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 30);
    // if (pickedFile != null) {
    //   final imageFile = File(pickedFile.path);
    //   final ref = await storageProvider.uploadFile(imageFile);
    //   ref.getDownloadURL().then((url) {
    //     final message = Message(
    //         senderUID: UserProvider.getCurrentUser().uid,
    //         senderName: UserProvider.getCurrentUser().displayName!,
    //         senderAvatar: UserProvider.getCurrentUser().photoURL,
    //         message: url,
    //         createdAt: DateTime.now().millisecondsSinceEpoch,
    //         type: 1);
    //     if (fromContact) {
    //       provider.sendMessageFromContact(id, message);
    //       ntfProvider.pushNotifyToPeer(
    //           UserProvider.getCurrentUser().displayName!,
    //           UserProvider.getCurrentUser().displayName! + ' send a photo',
    //           UserProvider.getCurrentUser().uid,
    //           deviceToken ?? []);
    //     } else {
    //       provider.sendMessage(id, message);
    //       ntfProvider.pushNotifyToPeer(
    //           name,
    //           UserProvider.getCurrentUser().displayName! + ' send a photo ',
    //           UserProvider.getCurrentUser().uid,
    //           deviceToken ?? []);
    //     }
    //   });
    // }
  }

  void _moveCursorToLast() {
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
  }
}
