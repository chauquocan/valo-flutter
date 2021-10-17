import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/app_binding.dart';
import 'app/routes/routes.dart';
import 'app/utils/store_service.dart';
import 'package:valo_chat_app/app/lang/lang.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('current id: ${Storage.getUser()?.id}');
    return GetMaterialApp(
      title: 'Valo getx chat app',
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: AppTheme.light,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      // SharePref.validExpire() == false ? null : HomeBinding(),
      home: Storage.validExpire() == false ? WelcomeScreen() : HomeScreen(),
    );
  }
}
