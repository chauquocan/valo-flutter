import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/modules/auth/auth.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../auth/login/login.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('chooselang'.tr),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

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
                RoundedButton(
                  text: 'signin'.tr,
                  onPressed: () => Get.to(
                    () => LoginScreen(),
                    binding: LoginBinding(),
                  ),
                ),
                RoundedButton(
                  text: 'signup'.tr,
                  onPressed: () => Get.to(
                    () => AuthScreen(),
                    binding: AuthBinding(),
                  ),
                  color: AppColors.light,
                  textColor: AppColors.primary,
                ),
                // SizedBox(height: size.height * 0.15),
                TextButton(
                  onPressed: () {
                    buildLanguageDialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'changelang'.tr,
                        style: const TextStyle(
                            color: AppColors.light,
                            decoration: TextDecoration.underline),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: AppColors.light,
                      ),
                    ],
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
