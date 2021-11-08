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

  //loading
  final isLoading = false.obs;

  @override
  void onInit() {
    getFriendReqList();
    super.onInit();
  }

  Future SendFriendReq(String toId) async {
    final response = await friendProvider.SendFriendRequest(
        Storage.getToken()!.accessToken, toId);
    if (response.ok) {
      print('da gui loi moi ket ban');
    } else {
      print(response.code);
      print('xay ra loi khi gui loi moi ket ban');
    }
  }

  Future getFriendReqList() async {
    final response =
        await friendProvider.GetFriendRequests(Storage.getToken()!.accessToken);
    if (response != null) {
      friendReqList.addAll(response);
      print(friendReqList.toString());
    } else {
      print('loi khi lay loi moi ket ban');
    }
  }

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
