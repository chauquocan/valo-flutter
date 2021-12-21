import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/friend_request_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class AddFriendController extends GetxController {
  final chatController = Get.find<TabConversationController>();
  final contactController = Get.find<TabContactController>();
  //User service
  final userProvider = Get.find<ProfileProvider>();
  final friendProvider = Get.find<FriendRequestProvider>();

  var searchController = TextEditingController();
  var suggestController = TextEditingController();

  final searchResults = <UserContent>[].obs;
  final suggestResults = <UserContent>[].obs;

  final friendReqList = <FriendRequest>[].obs;
  final userList = <UserContent>[].obs;
  final searchFormKey = GlobalKey<FormState>();
  final suggestFormKey = GlobalKey<FormState>();

  //loading
  final isLoading = false.obs;
  final isSuggestLoading = false.obs;
  //requestsLoaded
  final requestsLoaded = false.obs;
  //usersLoaded
  final usersLoadded = false.obs;
  final usersSuggested = false.obs;

  final isSearch = false.obs;
  final isSuggest = false.obs;

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
      return 'Enter name or phone to search';
    }
    return null;
  }

  String? suggestValidator(String value) {
    if (value.isEmpty) {
      return 'Enter address to search';
    }
    return null;
  }

  /* 
    Gửi lời mời
   */
  Future sendFriendReq(String toId) async {
    final response = await friendProvider.sendFriendRequest(toId);
    if (response.ok) {
      // isSent.value = true;
      customSnackbar().snackbarDialog('Success', 'Request sent');
    } else {
      customSnackbar().snackbarDialog('Fail', 'You already sent request');
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
          userList.add(UserContent(user: user.data!, friend: false));
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
      customSnackbar().snackbarDialog('Thông báo', 'Kết bạn thành công');
      chatController.getConversations();
      contactController.getContactsFromAPI();
      getFriendReqList();
      isAccepted.value = true;
    } else {
      customSnackbar().snackbarDialog('Thông báo', 'Có lỗi! hãy thử lại sau');
    }
  }

  Future rejectFriendRequest(String id) async {
    final response = await friendProvider.rejectFriendRequest(id);
    if (response.ok) {
      customSnackbar().snackbarDialog('Thông báo', 'Từ chối thành công');
    } else {
      customSnackbar().snackbarDialog('Thông báo', 'Có lỗi! hãy thử lại sau');
    }
  }

  /* 
    Search user
   */
  Future searchUser(String textToSearch) async {
    if (searchFormKey.currentState!.validate()) {
      isLoading.value = true;
      List<UserContent> _profiles = [];
      final currentUser = LocalStorage.getUser();
      final searchResponse = await userProvider.searchUser(
        textToSearch,
      );
      if (searchResponse.ok) {
        if (searchResponse.data!.content.length > 0) {
          Future.delayed(const Duration(milliseconds: 200), () {
            for (var item in searchResponse.data!.content) {
              if (currentUser!.phone != item.user.phone ||
                  currentUser.name != item.user.name) {
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
        isLoading.value = false;
        usersLoadded.value = false;
      }
    }
    isSearch.value = true;
  }

  /* 
    Search user by address
   */
  Future searchUserByAdress(String address) async {
    if (suggestFormKey.currentState!.validate()) {
      isSuggestLoading.value = true;
      List<UserContent> _profiles = [];
      final currentUser = LocalStorage.getUser();
      final searchResponse = await userProvider.searchUserByAddress(address);
      if (searchResponse.ok) {
        if (searchResponse.data!.content.length > 0) {
          Future.delayed(const Duration(milliseconds: 200), () {
            for (var item in searchResponse.data!.content) {
              if (currentUser!.phone != item.user.phone ||
                  currentUser.name != item.user.name) {
                _profiles.add(item);
              }
            }
            suggestResults.value = _profiles;
            isSuggestLoading.value = false;
            usersSuggested.value = true;
          });
        } else {
          isSuggestLoading.value = false;
          usersSuggested.value = false;
        }
      } else {
        isSuggestLoading.value = false;
        usersSuggested.value = false;
      }
    }
    isSuggest.value = true;
  }
}
