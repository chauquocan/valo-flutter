import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/auth/reset_password/reset_password_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key, required this.numberPhone})
      : super(key: key);
  final String numberPhone;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_backspace_rounded),
        backgroundColor: AppColors.primary,
        onPressed: () => Get.offAllNamed('/'),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: controller.resetFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'resetpassword'.toUpperCase().tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                //Password input
                Obx(
                  () => RoundedInputField(
                    controller: controller.passwordInput,
                    hintText: "Enter password",
                    password: controller.showPass.value,
                    textColor: AppColors.light,
                    icon: Icons.lock,
                    validator: (value) => Regex.passwordValidator(value!),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.onShowPass();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Icon(
                          controller.showPass.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.light,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => RoundedInputField(
                    controller: controller.confirmPasswordInput,
                    hintText: "Confirm password",
                    password: controller.showConfirmPass.value,
                    textColor: AppColors.light,
                    icon: Icons.lock,
                    validator: (value) => Regex.confirmPasswordValidator(
                        value!, controller.passwordInput.text),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.onShowConfirmPass();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Icon(
                          controller.showConfirmPass.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.light,
                        ),
                      ),
                    ),
                  ),
                ),
                //Sign up submit button
                RoundedButton(
                    buttonText: 'Reset password',
                    width: size.width * 0.8,
                    colors: const [AppColors.light, AppColors.light],
                    color: AppColors.light,
                    textColor: AppColors.dark,
                    onPressed: () => controller.resetPassword(
                        numberPhone, controller.confirmPasswordInput.text)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
