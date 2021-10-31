import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class AddFriendController extends GetxController {
  //User service
  final UserProvider userProvider;
  final _token = Storage.getToken()?.accessToken;

  AddFriendController({required this.userProvider});

  var searchController = TextEditingController();

  List<ProfileResponse> searchResults = [
    // ProfileResponse(
    //   id: '312312',
    //   name: 'quoc an',
    //   gender: 'dsda',
    //   dateOfBirth: 'dasd',
    //   phone: '0213124',
    //   email: 'email',
    //   address: 'address',
    //   imgUrl:
    //       'https://files.worldwildlife.org/wwfcmsprod/images/Panda_in_Tree/hero_full/2wgwt9z093_Large_WW170579.jpg',
    //   status: 'status',
    // )
  ];
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
      // addSearchlist(searchResponse.data);
    } else {
      Get.snackbar('Search failed', 'Something wrong');
    }
  }

  void addSearchlist(ProfileResponse? profileResponse) {
    searchResults.add(profileResponse!);
  }
}
