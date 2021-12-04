import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  //languages
  final List locale = [
    {'name': 'Vietnamese', 'locale': const Locale('vi', 'VN')},
    {'name': 'English', 'locale': const Locale('en', 'US')},
  ];
  int languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chooselang'.tr)),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: locale[0]['name'],
              trailing: trailingWidget(0),
              onPressed: (BuildContext context) {
                changeLanguage(locale[0]['locale'], 0);
              },
            ),
            SettingsTile(
              title: locale[1]['name'],
              trailing: trailingWidget(1),
              onPressed: (BuildContext context) {
                changeLanguage(locale[1]['locale'], 1);
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }

  void changeLanguage(Locale locale, int index) {
    setState(() {
      languageIndex = index;
      Get.updateLocale(locale);
    });
  }
}
