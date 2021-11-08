import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AddFriendController extends GetxController {
  //User service
  final UserProvider userProvider;

  AddFriendController({required this.userProvider});

  var searchController = TextEditingController();

  List<ProfileResponse> searchResults = [];
  //loading
  final isLoading = false.obs;

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
