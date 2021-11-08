import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/friend_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AddFriendController extends GetxController {
  //User service
  final UserProvider userProvider;
  final FriendProvider friendProvider;

  AddFriendController(
      {required this.userProvider, required this.friendProvider});

  var searchController = TextEditingController();

  List<ProfileResponse> searchResults = [];
  final friendReqList = <Content>[].obs;
  final userIdList = <ProfileResponse>[].obs;

  //loading
  final isLoading = false.obs;

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
            '${response[i].fromId}', Storage.getToken()!.accessToken);
        userIdList.add(user.data!);
      }
      friendReqList.addAll(response);
      print(friendReqList.toString());
    } else {
      print('loi khi lay loi moi ket ban');
    }
  }

  //Chấp nhận lời mời
  Future acceptFriendRequest(String id) async {
    final response = await friendProvider.AcceptFriendRequest(
        Storage.getToken()!.accessToken, id);
    if (response.ok) {
      Get.snackbar('Thanh cong', '${response.data}');
      friendReqList.value.clear();
    } else {
      Get.snackbar('That bai', '${response.data}');
    }
  }

  Future getUserById(String id) async {
    final response =
        await userProvider.getUserById(id, Storage.getToken()!.accessToken);
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
      isLoading.value = false;
      searchResults.clear();
      searchResults.add(ProfileResponse(
        id: searchResponse.data!.id,
        name: searchResponse.data!.name,
        gender: searchResponse.data!.gender,
        dateOfBirth: searchResponse.data!.dateOfBirth,
        phone: searchResponse.data!.phone,
        email: searchResponse.data!.email,
        address: searchResponse.data!.address,
        imgUrl: searchResponse.data!.imgUrl,
        status: searchResponse.data!.status,
      ));
      print(searchResults.length);
    } else {
      Get.snackbar('Search failed', 'Something wrong');
    }
  }
}
