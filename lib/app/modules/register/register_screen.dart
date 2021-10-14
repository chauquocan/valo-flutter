import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:valo_chat_app/app/modules/login/login_binding.dart';
import 'package:valo_chat_app/app/modules/register/register_binding.dart';
import 'dart:convert';

//components
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../login/login_screen.dart';
import '../home/home_screen.dart';
import 'register_controller.dart';

//utils
import 'package:valo_chat_app/app/themes/theme.dart';
// import 'package:valo_flutter_fontend/utils/url.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField _phoneInput = RoundedInputField(
      hintText: "Please enter phone number",
      textColor: AppColors.light,
      icon: Icons.phone,
      onChanged: (value) {},
    );
    RoundedInputField _emailInput = RoundedInputField(
      hintText: "Please enter email",
      textColor: AppColors.light,
      icon: Icons.email,
      onChanged: (value) {},
    );
    RoundedPasswordField _passwordInput = RoundedPasswordField(
      myHintText: 'Please enter password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    RoundedPasswordField _confirmPasswordInput = RoundedPasswordField(
      myHintText: 'Please confirm password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.keyboard_backspace_rounded),
            backgroundColor: AppColors.primary,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                _phoneInput,
                // _emailInput,
                _passwordInput,
                // _confirmPasswordInput,
                RoundedButton(
                    text: 'SIGN UP',
                    color: Colors.white,
                    textColor: AppColors.primary,
                    onPressed: () => controller.register(
                        _phoneInput.myController.text,
                        _passwordInput.myController.text)),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Get.off(() => LoginScreen(), binding: LoginBinding());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
