import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/message_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/utils/date.dart';
import 'package:valo_chat_app/app/utils/stomp_service.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class TabConversationController extends GetxController {
  final ChatProvider chatProvider;
  final ProfileProvider userProvider;

  TabConversationController({
    required this.chatProvider,
    required this.userProvider,
  });
  final scrollController = ScrollController();
  final _page = 0.obs;
  final isLoading = true.obs;
  final conversationsLoaded = false.obs;
  final conversations = <ConversationContent>[].obs;
  final userList = <Profile>[].obs;

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  @override
  void onReady() {
    paginateMessages();
    Future.delayed(Duration(milliseconds: 500), () {
      SubscribeChannel();
    });
    super.onReady();
  }

  SubscribeChannel() {
    StompService.stompClient.subscribe(
      destination: '/users/queue/messages',
      callback: (StompFrame frame) => onMessagesReceive(frame),
    );
    StompService.stompClient.subscribe(
      destination: '/users/queue/read',
      callback: (StompFrame frame) {
        var response = jsonDecode(frame.body!);
        print(response);
      },
    );
  }

  String lastMess(LastMessage? lastMess) {
    if (lastMess == null) return 'Send your first message';
    var mess = lastMess.message.content;
    if (lastMess.message.content.length > 10) {
      mess = lastMess.message.content.substring(0, 10) + ' ...  ';
    }
    if (lastMess.message.senderId != "") {
      if (lastMess.message.senderId == Storage.getUser()?.id) {
        if (lastMess.message.messageType == 'IMAGE') {
          return 'You send a photo';
        } else if (lastMess.message.messageType == 'STICKER') {
          return 'You send a sticker';
        } else if (lastMess.message.messageType == 3) {
          return 'You send a location';
        }
        return 'You : $mess  •  ${formatDate(lastMess.message.sendAt)}';
      } else {
        if (lastMess.message.messageType == 'IMAGE') {
          return '${lastMess.userName} send a photo';
        } else if (lastMess.message.messageType == 'STICKER') {
          return '${lastMess.userName} send a sticker';
        } else if (lastMess.message.messageType == 3) {
          return '${lastMess.userName} send a location';
        }
        return '${lastMess.userName} : $mess';
      }
    }
    return '$mess • ${formatDate(lastMess.message.sendAt)}';
  }

  Future onMessagesReceive(StompFrame frame) async {}

  /* 
    Get conversation
   */
  Future getConversations() async {
    List<ConversationContent> _conversations = [];
    String? currentUserId = Storage.getUser()?.id;
    final response = await chatProvider.GetConversations(_page.value);
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
                  ),
                );
              }
            }
          }
        }
        conversations.value = _conversations;
        isLoading.value = false;
        conversationsLoaded.value = true;
        _page.value++;
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
  Future getMoreConversation() async {
    List<ConversationContent> _conversations = [];
    String currentUserId = Storage.getUser()!.id;
    final response = await chatProvider.GetConversations(_page.value);
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
        print(_page.value);
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
}
