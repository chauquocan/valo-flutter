import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/friend_request_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AddFriendController extends GetxController {
  TabConversationController chatController = Get.find();
  //User service
  final UserProvider userProvider;
  final FriendRequestProvider friendProvider;

  AddFriendController(
      {required this.userProvider, required this.friendProvider});

  var searchController = TextEditingController();

  List<ProfileResponse> searchResults = [];
  final friendReqList = <FriendRequest>[].obs;
  final userIdList = <ProfileResponse>[].obs;

  //loading
  final isLoading = false.obs;
  //isSent
  final isSent = false.obs;

  @override
  void onInit() {
    getFriendReqList();
    super.onInit();
  }

  //Gửi lời mời
  Future SendFriendReq(String toId) async {
    final response = await friendProvider.SendFriendRequest(
        Storage.getToken()!.accessToken, toId);
    if (response.ok) {
      isSent.value = true;
      Get.snackbar('Success', 'Request sent');
    } else {
      Get.snackbar('Fail', 'Something wrong');
    }
  }

  //Lấy danh sách lời mời
  Future getFriendReqList() async {
    final response =
        await friendProvider.GetFriendRequests(Storage.getToken()!.accessToken);
    if (response != null) {
      for (var i = 0; i < response.length; i++) {
        final user = await userProvider.getUserById(
            '${response[i].fromId}');
        userIdList.add(user.data!);
      }
      friendReqList.addAll(response);
      print(friendReqList.toString());
    } else {
      print('loi khi lay loi moi ket ban');
    }
    update();
  }

  //Chấp nhận lời mời
  Future acceptFriendRequest(String id) async {
    final response = await friendProvider.AcceptFriendRequest(
        Storage.getToken()!.accessToken, id);
    if (response.ok) {
      Get.snackbar('Thanh cong', '${response.data}');
      chatController.onReady();
      friendReqList.value.clear();
    } else {
      Get.snackbar('That bai', '${response.data}');
    }
  }

  Future getUserById(String id) async {
    final response =
        await userProvider.getUserById(id);
    if (response.ok) {}
  }

  //Tìm user
  Future searchUser(String phoneNumber) async {
    isLoading.value = true;
    final searchResponse = await userProvider.searchUser(
      phoneNumber,
      Storage.getToken()!.accessToken,
    );
    print('Search respone: ${searchResponse.toString()}');
    if (searchResponse.ok) {
      searchResults.clear();
      searchResults.add(
        ProfileResponse(
          id: searchResponse.data!.id,
          name: searchResponse.data!.name,
          gender: searchResponse.data!.gender,
          dateOfBirth: searchResponse.data!.dateOfBirth,
          phone: searchResponse.data!.phone,
          email: searchResponse.data!.email,
          address: searchResponse.data!.address,
          imgUrl: searchResponse.data!.imgUrl,
          status: searchResponse.data!.status,
        ),
      );
      isLoading.value = false;
      print(searchResults.length);
    } else {
      Get.snackbar('Search failed', 'Something wrong');
    }
  }
}
