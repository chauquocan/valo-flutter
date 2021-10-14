import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home_binding.dart';
import 'package:valo_chat_app/app/modules/home/home_screen.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'app/routes/routes.dart';
import 'app/utils/share_pref.dart';
import 'app/routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharePref.initial();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(SharePref.getUser()?.id);
    return GetMaterialApp(
      title: 'Valo getx chat app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      getPages: AppPages.pages,
      initialBinding: SharePref.getUser() == null ? null : HomeBinding(),
      home: SharePref.getUser() == null ? const WelcomeScreen() : HomeScreen(),
    );
  }
}
