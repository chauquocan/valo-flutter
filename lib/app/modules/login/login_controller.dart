import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../data/providers/user_provider.dart';
import '../home/home_screen.dart';
import '../home/home_binding.dart';
import '../../utils/share_pref.dart';
import 'package:valo_chat_app/app/widgets/dialog_loading.dart';

class LoginController extends GetxController {
  final UserProvider userProvider;

  LoginController({required this.userProvider});

  Future login(String phoneNumber, String password) async {
    _showLoading();
    final map = {'username': phoneNumber, 'password': password};
    final response = await userProvider.login(map);
    print('Respone: ${response.toString()}');
    if (response.ok) {
      await SharePref.saveUser(response.data!);
      Get.offAll(() => HomeScreen(), binding: HomeBinding());
    } else {
      Get.back();
      if (response.code == HttpStatus.forbidden) {
        showInfoDialog('Login fail', 'Phone number or password incorrect');
      } else if (response.code == HttpStatus.unauthorized) {
        showInfoDialog('Login failed', 'User not found, please register');
      } else {
        showInfoDialog('Login failed', 'Sometihing went wrong, try again');
      }
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
