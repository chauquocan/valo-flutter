import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/routes/app_pages.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
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
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('current username: ${Storage.getUser()?.username}');
    return GetMaterialApp(
      title: 'Valo chat app',
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: AppTheme.light,
      getPages: AppPages.pages,
      initialRoute:
          Storage.ExpireToken() == false ? Routes.WELCOME : Routes.HOME,
    );
  }
}
