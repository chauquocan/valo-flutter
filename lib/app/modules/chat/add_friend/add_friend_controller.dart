import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
import 'package:valo_chat_app/app/data/providers/friend_request_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class AddFriendController extends GetxController {
  final chatController = Get.find<TabConversationController>();
  final contactController = Get.find<TabContactController>();
  //User service
  final ProfileProvider userProvider;
  final FriendRequestProvider friendProvider;

  AddFriendController(
      {required this.userProvider, required this.friendProvider});

  var searchController = TextEditingController();

  final searchResults = <Profile>[].obs;
  final friendReqList = <FriendRequest>[].obs;
  final userList = <Profile>[].obs;
  final searchFormKey = GlobalKey<FormState>();

  //loading
  final isLoading = false.obs;
  //requestsLoaded
  final requestsLoaded = false.obs;
  //usersLoaded
  final usersLoadded = false.obs;
  final isSearch = false.obs;
  final isAccepted = false.obs;
  //isSent
  final isSent = false.obs;

  @override
  void onInit() {
    getFriendReqList();
    super.onInit();
  }

  String? searchValidator(String value) {
    if (value.isEmpty) {
      return '';
    }
    if (RegExp(r"\s").hasMatch(value)) {
      return '';
    }
    return null;
  }

  /* 
    Gửi lời mời
   */
  Future sendFriendReq(String toId) async {
    final response = await friendProvider.sendFriendRequest(toId);
    if (response.ok) {
      isSent.value = true;
      Get.snackbar('Success', 'Request sent');
    } else {
      Get.snackbar('Fail', 'You already sent request',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /* 
    Lấy danh sách lời mời
   */
  Future getFriendReqList() async {
    isLoading.value = true;
    final response = await friendProvider.getFriendRequests();
    if (response.ok) {
      if (response.data!.content.length > 0) {
        for (var request in response.data!.content) {
          final user = await userProvider.getUserById(request.fromId);
          userList.add(user.data!);
        }
        friendReqList.value = response.data!.content;
        isLoading.value = false;
        requestsLoaded.value = true;
        update();
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = true;
    }
  }

  /* 
    Chấp nhận lời mời
   */
  Future acceptFriendRequest(String id) async {
    final response = await friendProvider.acceptFriendRequest(id);
    if (response.ok) {
      Get.snackbar('Thanh cong', '${response.data}');
      chatController.getConversations();
      contactController.getContactsFromAPI();
      isAccepted.value = true;
    } else {
      Get.snackbar('That bai', '${response.data}');
    }
  }

  /* 
    Search user
   */
  Future searchUser(String textToSearch) async {
    if (searchFormKey.currentState!.validate()) {
      isLoading.value = true;
      List<Profile> _profiles = [];
      final currentUser = LocalStorage.getUser();
      final searchResponse = await userProvider.searchUser(
        textToSearch,
      );
      if (searchResponse.ok) {
        if (searchResponse.data!.content.length > 0) {
          Future.delayed(const Duration(milliseconds: 200), () {
            // Do something
            for (var item in searchResponse.data!.content) {
              if (currentUser!.phone != item.phone ||
                  currentUser.name != item.name) {
                _profiles.add(item);
              }
            }
            searchResults.value = _profiles;
            isLoading.value = false;
            usersLoadded.value = true;
          });
        } else {
          isLoading.value = false;
          usersLoadded.value = false;
        }
      } else {
        Get.snackbar('Search failed', 'Something wrong');
        isLoading.value = false;
      }
    }
    isSearch.value = true;
  }
}
