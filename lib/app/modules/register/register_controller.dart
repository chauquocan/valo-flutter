import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:valo_chat_app/app/modules/login/login_binding.dart';
import 'package:valo_chat_app/app/modules/login/login_screen.dart';
import 'package:valo_chat_app/app/widgets/dialog_loading.dart';
import '../../data/providers/user_provider.dart';
import '../../utils/share_pref.dart';
import '../../widgets/widgets.dart';

class RegisterController extends GetxController {
  final UserProvider userProvider;

  RegisterController({required this.userProvider});

  Future register(String phoneNumber, String password) async {
    _showLoading();
    final map = {'username': phoneNumber, 'password': password};
    final response = await userProvider.register(map);
    print('Respone: ${response.toString()}');
    if (response.ok) {
      showInfoDialog('Sign up susscessfully', 'lets sign in');
      Get.offAll(() => LoginScreen(), binding: LoginBinding());
    } else {
      Get.back();
      showInfoDialog('Sign up failed', 'something went wrong');
    }
  }

  void _showLoading() {
    Get.dialog(const DialogLoading());
  }

  void showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(content),
    ));
  }
}
