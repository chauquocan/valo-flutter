import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/modules/login/login_binding.dart';
//components
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../login/login_screen.dart';
import '../register/register_screen.dart';
//utils
import 'package:valo_chat_app/app/themes/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _pushPage(BuildContext context, Widget page) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );
    }

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
                SizedBox(height: size.height * 0.25),
                // RoundedButton(
                //   text: "Đăng nhập",
                //   onPressed: () => _pushPage(context, LoginScreen()),
                // ),
                WidgetButton(
                  onTap: () => Get.to(
                    () => LoginScreen(),
                    binding: LoginBinding(),
                  ),
                  text: 'Login',
                ),
                RoundedButton(
                  text: 'Đăng ký',
                  onPressed: () => _pushPage(context, RegisterScreen()),
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

class WidgetButton extends StatelessWidget {
  final Function() onTap;
  final String text;

  const WidgetButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 40,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
