import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
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
  final conversations = <Conversation>[].obs;
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
    // StompService.stompClient.acctive
    StompService.stompClient.subscribe(
      destination: '/users/queue/messages',
      callback: (StompFrame frame) {
        var response = jsonDecode(frame.body!);
        print(response);
        getConversations();
      },
    );
    StompService.stompClient.subscribe(
      destination: '/users/queue/read',
      callback: (StompFrame frame) {
        var response = jsonDecode(frame.body!);
        print(response);
      },
    );
  }

  /* 
    Get conversation
   */
  Future getConversations() async {
    List<Conversation> _conversations = [];
    String? currentUserId = Storage.getUser()?.id;
    final response = await chatProvider.GetConversations(_page.value);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          if (content.conversation.conversationType == 'GROUP') {
            _conversations.add(
              Conversation(
                id: content.conversation.id,
                name: content.conversation.name,
                imageUrl: content.conversation.imageUrl,
                time: DateFormat('hh:mm').format(content.message.sendAt),
                lastMessage: content.message.content,
                isGroup: true,
                createAt: content.conversation.createAt,
                conversationType: content.conversation.conversationType,
                participants: content.conversation.participants,
                unread: content.unReadMessage,
              ),
            );
          } else {
            for (var participant in content.conversation.participants) {
              String userId = participant.userId;
              if (currentUserId != userId) {
                final user = await userProvider.getUserById(userId);
                _conversations.add(
                  Conversation(
                    id: content.conversation.id,
                    name: user.data!.name,
                    imageUrl: user.data!.imgUrl,
                    time: DateFormat('hh:mm').format(content.message.sendAt),
                    lastMessage: content.message.content,
                    isGroup: false,
                    createAt: content.conversation.createAt,
                    conversationType: content.conversation.conversationType,
                    participants: content.conversation.participants,
                    unread: content.unReadMessage,
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

  Future getMoreConversation() async {
    List<Conversation> _conversations = [];
    String currentUserId = Storage.getUser()!.id;
    final response = await chatProvider.GetConversations(_page.value);
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var content in response.data!.content) {
          if (content.conversation.conversationType == 'GROUP') {
            _conversations.add(
              Conversation(
                id: content.conversation.id,
                name: content.conversation.name,
                imageUrl: content.conversation.imageUrl,
                time: DateFormat('hh:mm').format(content.message.sendAt),
                lastMessage: content.message.content,
                isGroup: true,
                createAt: content.conversation.createAt,
                conversationType: content.conversation.conversationType,
                participants: content.conversation.participants,
                unread: content.unReadMessage,
              ),
            );
          } else {
            for (var participant in content.conversation.participants) {
              String userId = participant.userId;
              if (currentUserId != userId) {
                final user = await userProvider.getUserById(userId);
                _conversations.add(
                  Conversation(
                    id: content.conversation.id,
                    name: user.data!.name,
                    imageUrl: user.data!.imgUrl,
                    time: DateFormat('hh:mm').format(content.message.sendAt),
                    lastMessage: content.message.content,
                    isGroup: false,
                    createAt: content.conversation.createAt,
                    conversationType: content.conversation.conversationType,
                    participants: content.conversation.participants,
                    unread: content.unReadMessage,
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
