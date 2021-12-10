import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_controller.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

//Welcome screen
class WelcomeScreen extends StatelessWidget {
  final controller = Get.put(WelcomeController());

  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.1),
                //Sign in button
                RoundedButton(
                  buttonText: 'signin'.tr,
                  colors: const [AppColors.primary, AppColors.secondary],
                  color: Colors.blue.shade300,
                  width: size.width * 0.8,
                  onPressed: () => Get.toNamed('/login'),
                ),
                //Sign up button
                RoundedButton(
                  buttonText: 'signup'.tr,
                  width: size.width * 0.8,
                  colors: const [AppColors.light, AppColors.hintLight],
                  color: AppColors.light,
                  textColor: AppColors.dark,
                  onPressed: () => Get.toNamed('/auth'),
                ),
                //Choose language button
                TextButton(
                  onPressed: () {
                    controller.buildLanguageDialog(context);
                  },
                  child: Text(
                    'changelang'.tr,
                    style: const TextStyle(
                        color: AppColors.light,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
