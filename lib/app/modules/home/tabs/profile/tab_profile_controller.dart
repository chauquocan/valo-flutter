import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class TabProfileController extends GetxController {
  //user service
  final ProfileProvider userProvider;
  final AuthProvider authProvider;

  //text field controller
  final TextEditingController inputName = TextEditingController();
  final TextEditingController inputPhone = TextEditingController();
  final TextEditingController inputEmail = TextEditingController();
  final TextEditingController inputAdress = TextEditingController();
  final TextEditingController inputDate = TextEditingController();
  final TextEditingController inputGender = TextEditingController();

  TabProfileController(
      {required this.userProvider, required this.authProvider});

  var isLoading = false.obs;
  //image
  final ImagePicker _picker = ImagePicker();
  var imageURL = '';

  final editFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    inputName.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
    inputAdress.dispose();
    super.onClose();
  }

  //upload image function
  void uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile =
          await _picker.pickImage(source: imageSource, imageQuality: 50);
      isLoading(true);
      if (pickedFile != null) {
        var response = await userProvider.uploadFile(pickedFile.path);
        if (response.ok) {
          //get image url from api response
          imageURL = response.data!.imgUrl;
          print(response.data);
          print(imageURL);
          await LocalStorage.updateUser(response.data!);
          Get.snackbar('Success', 'Image uploaded successfully',
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
        } else if (response.code == HttpStatus.unauthorized) {
          Get.snackbar('Unauthorization', 'token expired');
        } else {
          Get.snackbar('Failed', 'Error Code: $response',
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
        }
      } else {
        Get.snackbar('Failed', 'Image not selected',
            margin: const EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      isLoading(false);
    }
  }

  //Edit profile infomation function
  Future editProfileInfo(String name, String gender, String phone, String email,
      String address, String birhDay) async {
    if (editFormKey.currentState!.validate()) {
      final map = {
        'name': name,
        'gender': gender,
        'dateOfBirth': birhDay,
        'phone': phone,
        'email': email,
        'address': address,
      };
      try {
        final response = await ProfileProvider().updateUserInfo(map);
        print('Update Response: ${response.toString()}');
        if (response.ok) {
          final userResponse = await ProfileProvider().getUserByPhone(
              phone, LocalStorage.getToken()!.accessToken.toString());
          Get.snackbar('update susscessfully', '');
          if (userResponse.ok) {
            await LocalStorage.updateUser(userResponse.data!);
            Get.reload();
          } else {
            Get.back();
          }
        } else {
          if (response.code == HttpStatus.forbidden) {
            Get.snackbar('failed', 'Sometihing went wrong, try again');
          } else if (response.code == HttpStatus.unauthorized) {
            Get.snackbar('failed', 'Sometihing went wrong, try again');
          } else {
            Get.snackbar('failed', 'Sometihing went wrong, try again');
          }
        }
      } finally {
        // TODO
      }
    }
  }

  //Logout
  Future logout() async {
    final response = await authProvider.logout();
    LocalStorage.logout();
    Get.offAllNamed('/');
  }

  Future refreshToken() async {
    final response = await authProvider.refreshToken();
    if (response.ok) {
      print(response);
    } else {
      print(response);
    }
  }
}
