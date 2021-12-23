import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/stomp_service.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class TabConversationController extends GetxController {
  final chatProvider = Get.find<ChatProvider>();
  final userProvider = Get.find<ProfileProvider>();

  final scrollController = ScrollController();
  final _page = 1.obs;
  final isLoading = true.obs;
  final conversationsLoaded = false.obs;
  final conversations = <ConversationContent>[].obs;
  final userList = <User>[].obs;

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  @override
  void onReady() {
    paginateMessages();
    refresh();
    Future.delayed(const Duration(milliseconds: 500), () {
      subscribeChannel();
    });
    super.onReady();
  }

  void subscribeChannel() async {
    StompService.stompClient.subscribe(
      destination: '/users/queue/messages',
      callback: (StompFrame frame) => onMessagesReceive(frame),
    );
  }

  Future onMessagesReceive(StompFrame frame) async {
    var socket = jsonDecode(frame.body!);
    LastMessage mess = LastMessage.fromJson(socket);
    var conversation = conversations.value.firstWhere((e) =>
        e.lastMessage.message.conversationId == mess.message.conversationId);
    conversation.lastMessage.message = mess.message;
    conversations.remove(conversation);
    conversations.insert(0, conversation);
    conversations.refresh();
    if (mess.message.senderId != LocalStorage.getUser()?.id) {
      conversation.unReadMessage++;
      sendNotification(conversation);
    }
  }

  String lastMess(ConversationContent? conversation) {
    if (conversation == null) return 'Send your first message';
    var mess = conversation.lastMessage.message.content;
    if (conversation.lastMessage.message.content.length > 30) {
      mess =
          conversation.lastMessage.message.content.substring(0, 30) + ' ...  ';
    }
    if (conversation.lastMessage.message.senderId != "") {
      if (conversation.lastMessage.message.senderId ==
          LocalStorage.getUser()?.id) {
        if (conversation.lastMessage.message.messageType == 'IMAGE') {
          return 'You send a photo';
        } else if (conversation.lastMessage.message.messageType == 'STICKER') {
          return 'You send a sticker';
        } else if (conversation.lastMessage.message.messageType == 'FILE') {
          return 'You send a file';
        } else if (conversation.lastMessage.message.messageType == 'VIDEO') {
          return 'You send a video';
        }
        return 'You : $mess';
      } else {
        if (conversation.isGroup) {
          if (conversation.lastMessage.message.messageType == 'IMAGE') {
            return '${conversation.lastMessage.userName} send a photo';
          } else if (conversation.lastMessage.message.messageType ==
              'STICKER') {
            return '${conversation.lastMessage.userName} send a sticker';
          } else if (conversation.lastMessage.message.messageType == 'VIDEO') {
            return '${conversation.lastMessage.userName} send a video';
          } else if (conversation.lastMessage.message.messageType == 'FILE') {
            return '${conversation.lastMessage.userName} send a file';
          }
          return mess;
        }
        if (conversation.lastMessage.message.messageType == 'IMAGE') {
          return '${conversation.lastMessage.userName} send a photo';
        } else if (conversation.lastMessage.message.messageType == 'STICKER') {
          return '${conversation.lastMessage.userName} send a sticker';
        } else if (conversation.lastMessage.message.messageType == 'VIDEO') {
          return '${conversation.lastMessage.userName} send a video';
        } else if (conversation.lastMessage.message.messageType == 'FILE') {
          return '${conversation.lastMessage.userName} send a file';
        }
        return mess;
      }
    }
    return mess;
  }

  /* 
    Get conversation
   */
  Future<void> getConversations() async {
    isLoading.value = true;
    List<ConversationContent> _conversations = [];
    String? currentUserId = LocalStorage.getUser()?.id;
    final response = await chatProvider.getConversations(0);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          if (content.conversation.conversationType == 'GROUP') {
            _conversations.add(
              ConversationContent(
                conversation: content.conversation,
                lastMessage: content.lastMessage,
                unReadMessage: content.unReadMessage,
                isGroup: true,
              ),
            );
          } else {
            for (var participant in content.conversation.participants) {
              String userId = participant.userId;
              if (currentUserId != userId) {
                final user = await userProvider.getUserById(userId);
                _conversations.add(
                  ConversationContent(
                    conversation: Conversation(
                        id: content.conversation.id,
                        createAt: content.conversation.createAt,
                        conversationType: content.conversation.conversationType,
                        participants: content.conversation.participants,
                        name: user.data!.name,
                        createdByUserId: content.conversation.createdByUserId,
                        imageUrl: user.data!.imgUrl),
                    lastMessage: content.lastMessage,
                    unReadMessage: content.unReadMessage,
                    isGroup: false,
                    status: user.data!.status,
                  ),
                );
              }
            }
          }
        }
        conversations.value = _conversations;
        isLoading.value = false;
        conversationsLoaded.value = true;
        conversations.refresh();
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = true;
    }
  }

  /* 
    Get more conversation when scroll to end
   */
  Future<void> getMoreConversation() async {
    List<ConversationContent> _conversations = [];
    String currentUserId = LocalStorage.getUser()!.id;
    final response = await chatProvider.getConversations(_page.value);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          if (content.conversation.conversationType == 'GROUP') {
            _conversations.add(
              ConversationContent(
                conversation: content.conversation,
                lastMessage: content.lastMessage,
                unReadMessage: content.unReadMessage,
                isGroup: true,
              ),
            );
          } else {
            for (var participant in content.conversation.participants) {
              String userId = participant.userId;
              if (currentUserId != userId) {
                final user = await userProvider.getUserById(userId);
                _conversations.add(
                  ConversationContent(
                    conversation: Conversation(
                        id: content.conversation.id,
                        createAt: content.conversation.createAt,
                        conversationType: content.conversation.conversationType,
                        participants: content.conversation.participants,
                        name: user.data!.name,
                        createdByUserId: content.conversation.createdByUserId,
                        imageUrl: user.data!.imgUrl),
                    lastMessage: content.lastMessage,
                    unReadMessage: content.unReadMessage,
                    isGroup: false,
                    status: user.data!.status,
                  ),
                );
              }
            }
          }
        }
        conversations.value.addAll(_conversations);
        isLoading.value = false;
        conversationsLoaded.value = true;
        _page.value++;
      }
    } else {
      isLoading.value = true;
    }
  }

  /* 
    Pagination
   */
  paginateMessages() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getMoreConversation();
        update();
      }
    });
  }

  void sendNotification(ConversationContent conversation) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: '_message',
        title: conversation.lastMessage.userName,
        body: lastMess(conversation),
        backgroundColor: Colors.lightBlue,
      ),
    );

    try {
      AwesomeNotifications().actionStream.listen((event) {
        Get.toNamed('/chat', arguments: {
          "id": conversation.conversation.id,
          "name": conversation.conversation.name,
          "participants": conversation.conversation.participants,
          "avatar": conversation.conversation.imageUrl,
          "isGroup": conversation.isGroup,
          "unreadMess": conversation.unReadMessage,
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
