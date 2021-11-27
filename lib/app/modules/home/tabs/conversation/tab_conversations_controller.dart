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

  String lastMess(Message? last) {
    if (last == null) return 'Send your first message';
    var mess = last.content;
    if (last.content.length > 10) {
      mess = last.content.substring(0, 10) + ' ...  ';
    }
    if (last.senderId != "") {
      if (last.senderId == Storage.getUser()?.id) {
        if (last.messageType == 'IMAGE') {
          return 'You send a photo';
        } else if (last.messageType == 'STICKER') {
          return 'You send a sticker';
        } else if (last.messageType == 3) {
          return 'You send a location';
        }
        return 'You : $mess  •  ${formatDate(last.sendAt)}';
      } else {
        if (last.messageType == 'IMAGE') {
          return '${last.senderId} send a photo';
        } else if (last.messageType == 'STICKER') {
          return '${last.senderId} send a sticker';
        } else if (last.messageType == 3) {
          return '${last.senderId} send a location';
        }
        return '${last.senderId} : $mess  •  ${formatDate(last.sendAt)}';
      }
    }
    return '$mess • ${formatDate(last.sendAt)}';
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
