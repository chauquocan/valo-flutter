import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';
import 'package:valo_chat_app/app/widgets/custom/dialog_loading.dart';

class TabProfileController extends GetxController {
  final UserProvider provider;
  var isLoading = false.obs;
  var imageURL = '';

  TabProfileController({required this.provider});

  void uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      isLoading(true);
      if (pickedFile != null) {
        var response = await provider.uploadFile(pickedFile.path);
        if (response.ok) {
          //get image url from api response
          imageURL = response.data!.imgUrl;
          print(imageURL);
          Get.snackbar('Success', 'Image uploaded successfully',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        } else if (response.code == HttpStatus.unauthorized) {
          Get.snackbar('Unauthorization', 'token expired');
        } else {
          Get.snackbar('Failed', 'Error Code: ${response}',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        }
      } else {
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      isLoading(false);
    }
  }

  void back() {
    Get.dialog(const DialogLoading());
    Get.back();
  }

  void logout() {
    Get.dialog(const DialogLoading());
    Storage.logout();
    Get.offAllNamed('/');
  }
}
