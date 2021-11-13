import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/data/models/profile_model.dart';
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

  List<Profile> searchResults = [];
  final friendReqList = <FriendRequest>[].obs;
  final userList = <Profile>[].obs;

  //loading
  final isLoading = false.obs;
  //listLoaded
  final requestsLoaded = false.obs;
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
    isLoading.value = true;
    List<FriendRequest> _friendList = [];
    final response =
        await friendProvider.GetFriendRequests(Storage.getToken()!.accessToken);
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
    final response = await userProvider.getUserById(id);
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
        Profile(
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
