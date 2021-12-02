import 'dart:async';
import 'dart:convert';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/stomp_service.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class ChatController extends GetxController {
  final conversationController = Get.find<TabConversationController>();
  final ChatProvider chatProvider;
  final ProfileProvider profileProvider;
  final GroupChatProvider groupChatProvider;

  TabContactController contactController = Get.find();

  ChatController({
    required this.chatProvider,
    required this.profileProvider,
    required this.groupChatProvider,
  });

  final textController = TextEditingController();
  final keyboardController = KeyboardVisibilityController();
  final scrollController = ScrollController();
  final currentUserId = LocalStorage.getUser()?.id;

  final _id = ''.obs;
  final _name = ''.obs;
  final _avatar = ''.obs;
  final _senderAvatar = <String>[].obs;
  final _isGroup = false.obs;
  final _page = 0.obs;

  final _users = <User>[].obs;

  List<User> get users => _users;

  set users(value) {
    _users.value = value;
  }

  //
  final _participants = <Participant>[].obs;

  List<Participant> get participants => _participants;

  set participants(value) {
    _participants.value = value;
  }

  final _emojiShowing = false.obs;
  final _stickerShowing = false.obs;
  final _gifShowing = false.obs;
  final _showMore = false.obs;
  final _showMoreMess = false.obs;
  final _isKeyboardVisible = false.obs;
  final _messages = <MessageContent>[].obs;
  final _isLoading = true.obs;
  final _messagesLoaded = false.obs;

  final _tagging = false.obs;
  final _members = <User>[].obs;
  final _listTagged = <User>[].obs;

  get showMore => _showMore.value;

  set showMore(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
    _showMore.value = value;
  }

  get showMoreMess => _showMoreMess.value;

  set showMoreMess(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
    _showMoreMess.value = value;
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

  get senderAvatar => _senderAvatar.value;

  set senderAvatar(value) {
    _senderAvatar.value = value;
  }

  get isGroup => _isGroup.value;

  set isGroup(value) {
    _isGroup.value = value;
  }

  get emojiShowing => _emojiShowing.value;

  set emojiShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && stickerShowing || value && gifShowing) {
      stickerShowing = false;
      gifShowing = false;
    }
    _emojiShowing.value = value;
  }

  get stickerShowing => _stickerShowing.value;

  set stickerShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && emojiShowing || value && gifShowing) {
      emojiShowing = false;
      gifShowing = false;
    }
    _stickerShowing.value = value;
  }

  get gifShowing => _gifShowing.value;

  set gifShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && stickerShowing || value && emojiShowing) {
      emojiShowing = false;
      stickerShowing = false;
    }
    _gifShowing.value = value;
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

  List<MessageContent> get messages => _messages;

  set messages(value) {
    _messages.value = value;
  }

  get tagging => _tagging.value;

  set tagging(value) {
    _tagging.value = value;
  }

  List<User> get members => _members;

  List<User> get membersWithoutMe => _members
      .where((element) => element.id != LocalStorage.getUser()?.id)
      .toList();

  set members(value) {
    _members.value = value;
  }

  List<User> get listTagged => _listTagged;

  set listTagged(value) {
    _listTagged.value = value;
  }

  /*------------------------*/
  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    name = Get.arguments['name'];
    avatar = Get.arguments['avatar'];
    isGroup = Get.arguments['isGroup'];
    participants = Get.arguments['participants'];

    getmembers();
    getMessages(id, _page.value);

    StompService.stompClient.subscribe(
      destination: '/users/queue/messages',
      callback: (StompFrame frame) => onMessageReceive(frame),
    );
    StompService.stompClient.subscribe(
      destination: '/users/queue/messages/delete',
      callback: (StompFrame frame) => onCancelMessage(frame),
    );

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      this.isKeyboardVisible = isKeyboardVisible;
      if (isKeyboardVisible && emojiShowing) {
        emojiShowing = false;
      } else if (isKeyboardVisible && stickerShowing) {
        stickerShowing = false;
      } else if (isKeyboardVisible && gifShowing) {
        gifShowing = false;
      } else if (isKeyboardVisible && showMore) {
        showMore = false;
      }
    });
  }

  @override
  void onReady() {
    // updateReadMessage();
    paginateMessages();
    super.onReady();
  }

  @override
  void onClose() {
    textController.clear();
    super.onClose();
  }

  //get member in group
  Future getmembers() async {
    List<User> membersTemp = [];
    for (var content in participants) {
      final profile = await profileProvider.getUserById(content.userId);
      if (profile.ok) {
        membersTemp.add(profile.data!);
      }
    }
    members.assignAll(membersTemp);
  }

  // kick member
  Future kickMember(userId, conversationId) async {
    final map = {'userId': userId, 'conversationId': conversationId};
    final respones = await groupChatProvider.kickMember(map);
    if (respones.ok) {
      Get.snackbar('Sucessful', 'Member has been kicked');
      Get.back();
    } else {
      Get.snackbar('Failed', 'You are not Admin');
    }
  }

  ///////// add member
  // Future addMember(userId, conversationId) async {
  //   final map = {'userId': userId, 'conversationId': conversationId};
  //   final respones = await groupChatProvider.addMember(map);
  //   if (respones.ok) {
  //     Get.back();
  //     Get.snackbar('Sucessful', 'Member has been added');
  //   } else
  //     (print(respones));
  //   Get.snackbar('Failed', 'You are not Admin');
  // }

  // // lấy ds bạn bè k có trong conversation
  // Future getContacts() async {
  //   contactController.getContactsFromAPI();
  //   users.clear();
  //   for (var contact in contactController.contactId) {
  //     final user = await profileProvider.getUserById(contact.friendId);
  //     for (Profile content in members) {
  //       if (content.id != user.data!.id) {
  //         users.add(
  //           Profile(
  //               id: user.data!.id,
  //               name: user.data!.name,
  //               gender: user.data!.gender,
  //               dateOfBirth: user.data!.dateOfBirth,
  //               phone: user.data!.phone,
  //               email: user.data!.email,
  //               address: user.data!.address,
  //               imgUrl: user.data!.imgUrl,
  //               status: user.data!.status),
  //         );
  //       }
  //     }
  //   }
  // }

  // leave group
  Future leaveGroup(String id) async {
    final respones = await groupChatProvider.leaveGroup(id);
    if (respones.ok) {
      Get.back();
    } else
      print(respones);
  }

  // delete group
  Future deleteGroup(String id) async {
    final respones = await groupChatProvider.deleteGroup(id);
    if (respones.ok) {
      Get.back();
      Get.snackbar('Sucessful', 'Member has been added');
    } else
      print(respones);
    Get.snackbar('Failed', 'You are not Admin');
  }

  ///
  /*------------------------*/
  Future onMessageReceive(StompFrame frame) async {
    var response = jsonDecode(frame.body!);
    MessageContent mess = MessageContent.fromJson(response);
    messages.insert(0, mess);
    _messages.refresh();
  }

  Future onCancelMessage(StompFrame frame) async {
    var response = jsonDecode(frame.body!);
    MessageContent mess = MessageContent.fromJson(response);
    var text =
        messages.firstWhere((element) => element.message.id == mess.message.id);
    text.message = mess.message;
    _messages.refresh();
  }

  /* 
    Get Messages
   */
  Future getMessages(String id, int page) async {
    List<MessageContent> _messages = [];
    final response = await chatProvider.getMesages(id, page);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          _messages.add(content);
        }
        messages.assignAll(_messages);
        isLoading = false;
        messagesLoaded = true;
        _page.value++;
      } else {
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
    List<MessageContent> _messages = [];
    final response = await chatProvider.getMesages(id, page);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          _messages.add(content);
          // final sender = await profileProvider.getUserById(message.senderId);
          // senderAvatar.add(sender.data?.imgUrl);
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

  void onTagSelect(User user) {
    tagging = !tagging;
    textController.text += user.name;
    listTagged.add(user);
    _moveCursorToLast();
  }

  void sendTextMessage() {
    if (textController.text.isNotEmpty) {
      String body = json.encode({
        "conversationId": '$id',
        "messageType": 0,
        "content": textController.text,
        "senderId": '$currentUserId',
        "replyId": '',
      });
      StompService.stompClient.send(
        destination: "/app/chat",
        body: body,
      );
      if (messages.length >= 1) {
        scrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
      textController.clear();
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

  void updateReadMessage() async {
    for (var mess in messages) {
      String body = json.encode({
        "messageId": mess.message.id,
        "conversationId": id,
        "userId": currentUserId,
        "readAt": DateTime.now(),
      });
      StompService.stompClient.send(
        destination: "/app/read",
        body: body,
      );
    }
  }

  void sendSticker(String? url) async {
    String body = json.encode({
      "conversationId": '$id',
      "messageType": 2,
      "content": url,
      "senderId": '$currentUserId',
      "replyId": '',
    });
    StompService.stompClient.send(
      destination: "/app/chat",
      body: body,
    );

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

  void sendGif(context) async {
    final gif = await GiphyGet.getGif(
      context: context, //Required
      apiKey: "uBomexw9lSfEywwVUChAqN3JnyPEZiaK", //Required.
      lang: GiphyLanguage.english, //Optional - Language for query.
      randomID: "abcd", // Optional - An ID/proxy for a specific user.
      searchText: "Search GIPHY", //Optional - AppBar search hint text.
      tabColor: Colors.teal, // Optional- default accent color.
    );
    if (gif != null) {
      // print(gif);
      String body = json.encode({
        "conversationId": '$id',
        "messageType": 2,
        "content": gif.images?.original?.webp,
        "senderId": '$currentUserId',
        "replyId": '',
      });
      StompService.stompClient.send(
        destination: "/app/chat",
        body: body,
      );
    }
  }

  void pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      var response = await chatProvider.uploadFile(pickedFile.path);
      if (response.statusCode == 200) {
        final listFile = [];
        for (var image in response.data) {
          String body = json.encode({
            "conversationId": '$id',
            "messageType": 1,
            "content": image,
            "senderId": '${LocalStorage.getUser()!.id}',
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
  }

  void pickImagesFromGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result != null) {
      var response = await chatProvider.uploadFiles(result.paths);
      if (response.statusCode == 200) {
        for (var image in response.data) {
          String body = json.encode({
            "conversationId": '$id',
            "messageType": 1,
            "content": image,
            "senderId": '${LocalStorage.getUser()!.id}',
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
      // User canceled the picker
    }
  }

  void pickFilesFromGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: true);

    if (result != null) {
      var response = await chatProvider.uploadFiles(result.paths);
      if (response.statusCode == 200) {
        for (var image in response.data) {
          String body = json.encode({
            "conversationId": '$id',
            "messageType": 5,
            "content": image,
            "senderId": '${LocalStorage.getUser()!.id}',
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
      // User canceled the picker
    }
  }

  Future deleteMessage(String messageId) async {
    final text =
        messages.firstWhere((element) => element.message.id == messageId);
    if (text.message.senderId == currentUserId) {
      CustomDialog().confirmDialog(
        'Lưu ý',
        'Bạn có chắc muốn thu hồi tin nhắn này?',
        () async {
          if (text.message.messageStatus != 'CANCELED') {
            await chatProvider.deleteMessage(messageId);
            Get.back();
          } else {
            Get.snackbar('Thong bao', 'tin nhan nay da duoc thu hoi');
          }
        },
        () => Get.back(),
      );
    } else {
      Get.snackbar(
          'Thong bao', 'ban khong the thu hoi tin nhan cua nguoi khac');
    }
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
    } else if (gifShowing) {
      toggleEmojiKeyboard();
      gifShowing = !gifShowing;
    } else {
      Navigator.pop(Get.context!);
    }
    return Future.value(false);
  }

  void _moveCursorToLast() {
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
  }
}
