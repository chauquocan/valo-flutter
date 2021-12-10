import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class ResetPasswordController extends GetxController {
  final authProvider = Get.find<AuthProvider>();
  final resetFormKey = GlobalKey<FormState>();

  final passwordInput = TextEditingController();
  final confirmPasswordInput = TextEditingController();

  final isLoading = false.obs;

  //pass's state
  final showPass = true.obs;
  final showConfirmPass = true.obs;

  //Show pass
  void onShowPass() => showPass.value = !showPass.value;
  void onShowConfirmPass() => showConfirmPass.value = !showConfirmPass.value;

  Future resetPassword(String phone, String newPassword) async {
    if (resetFormKey.currentState!.validate()) {
      final response = await authProvider.resetPassword(phone, newPassword);
      if (response.ok) {
        Get.offAllNamed('/');
      } else {
        customSnackbar().snackbarDialog('Something wrong', 'Try again');
      }
    }
  }
}
