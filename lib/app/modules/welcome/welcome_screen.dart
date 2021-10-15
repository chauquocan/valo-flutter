import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
//components
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../auth/login/login.dart';
import '../auth/register/register.dart';
//utils
import 'package:valo_chat_app/app/themes/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                const Text(
                  'WELCOME TO VALO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                SvgPicture.asset(
                  'assets/images/banner_mockup.svg',
                ),
                SizedBox(height: size.height * 0.1),
                RoundedButton(
                  text: "Đăng nhập",
                  onPressed: () => Get.to(
                    () => LoginScreen(),
                    binding: LoginBinding(),
                  ),
                ),
                RoundedButton(
                  text: 'Đăng ký',
                  onPressed: () => Get.to(
                    () => RegisterScreen(),
                    binding: RegisterBinding(),
                  ),
                  color: Colors.white,
                  textColor: AppColors.primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
