
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  //languages
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
  ];

  //Get language
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  //Choosing language dialog
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
}