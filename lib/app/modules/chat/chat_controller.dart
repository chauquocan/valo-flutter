import 'dart:async';
import 'dart:convert';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
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
  final _avatar = ''.obs;
  final _isGroup = false.obs;
  final _page = 0.obs;

  final _emojiShowing = false.obs;
  final _stickerShowing = false.obs;
  final _showMore = false.obs;
  final _isKeyboardVisible = false.obs;
  final _messages = <Message>[].obs;
  final _isLoading = true.obs;
  final _messagesLoaded = false.obs;

  final _tagging = false.obs;
  final _members = <Profile>[].obs;
  final _listTagged = <Profile>[].obs;

  get showMore => _showMore.value;

  set showMore(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
    _showMore.value = value;
  }

  get id => _id.value;

  set id(value) {
    _id.value = value;
  }

  get name => _name.value;

  set name(value) {
    _name.value = value;
  }

  get avatar => _avatar.value;

  set avatar(value) {
    _avatar.value = value;
  }

  get isGroup => _isGroup.value;

  set isGroup(value) {
    _isGroup.value = value;
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

  get messagesLoaded => _messagesLoaded.value;

  set messagesLoaded(value) {
    _messagesLoaded.value = value;
  }

  List<Message> get messages => _messages;

  set messages(value) {
    _messages.value = value;
  }

  get tagging => _tagging.value;

  set tagging(value) {
    _tagging.value = value;
  }

  List<Profile> get members => _members;

  List<Profile> get membersWithoutMe =>
      _members.where((element) => element.id != Storage.getUser()?.id).toList();

  set members(value) {
    _members.value = value;
  }

  List<Profile> get listTagged => _listTagged;

  set listTagged(value) {
    _listTagged.value = value;
  }

  /*------------------------*/
  @override
  void onInit() {
    id = Get.arguments['id'];
    name = Get.arguments['name'];
    avatar = Get.arguments['avatar'];
    isGroup = Get.arguments['isGroup'];
    super.onInit();
    getMessages(id, _page.value);
    StompService.stompClient.subscribe(
      destination: '/users/queue/messages',
      callback: (StompFrame frame) => OnMessageReceive(frame),
    );
  }

  @override
  void onReady() {
    paginateMessages();
    super.onReady();
  }

  @override
  void onClose() {
    textController.clear();
    super.onClose();
  }

  /*------------------------*/
  void AddMess(Message mess) {
    messages.insert(0, mess);
    update();
  }

  void OnMessageReceive(StompFrame frame) {
    var response = jsonDecode(frame.body!);
    print(response);
    Message mess = Message.fromJson(response);
    AddMess(mess);
    update();
  }

  /* 
    Get Messages
   */
  Future getMessages(String id, int page) async {
    List<Message> _messages = [];
    final response = await provider.GetMessages(id, page);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var message in response.data!.content) {
          _messages.add(message);
        }
        messages.assignAll(_messages);
        isLoading = false;
        messagesLoaded = true;
        _page.value++;
      } else {
        print('ko co mess');
        isLoading = false;
        messagesLoaded = false;
      }
    } else {
      print(response);
    }
  }

  /* 
    Get more messages page
   */
  Future getMoreMessages(String id, int page) async {
    List<Message> _messages = [];
    final response = await provider.GetMessages(id, page);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var message in response.data!.content) {
          _messages.add(message);
        }
        messages.addAll(_messages);
        isLoading = false;
        messagesLoaded = true;
        _page.value++;
      }
    } else {
      print(response);
    }
  }

  /* 
    Pagination
   */
  paginateMessages() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getMoreMessages(id, _page.value);
        update();
      }
    });
  }

  // void onTagSelect(ProfileResponse user) {
  //   tagging = !tagging;
  //   textController.text += user.name;
  //   listTagged.add(user);
  //   _moveCursorToLast();
  // }

  void sendMessage(String id) {
    if (textController.text.isNotEmpty) {
      String body = json.encode({
        "conversationId": '${id}',
        "messageType": 0,
        "content": '${textController.text}',
        "senderId": '${Storage.getUser()!.id}',
        "replyId": '',
      });
      StompService.stompClient.send(
        destination: "/app/chat",
        body: body,
      );
      textController.clear();
      if (messages.length >= 1) {
        scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }

    // textController.
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
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      var response = await provider.uploadFile(pickedFile.path);
      if (response.statusCode == 200) {
        final listFile = [];
        for (var file in response.data) {
          String body = json.encode({
            "conversationId": '${id}',
            "messageType": 1,
            "content": file,
            "senderId": '${Storage.getUser()!.id}',
            "replyId": '',
          });
          StompService.stompClient.send(
            destination: "/app/chat",
            body: body,
          );
        }
        textController.clear();
        if (messages.length >= 1) {
          scrollController.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      } else {
        print(response);
        Get.snackbar('Loi', "Loi gui api");
      }
    } else {
      Get.snackbar('Luu y ', "Vui long chon anh");
    }

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
