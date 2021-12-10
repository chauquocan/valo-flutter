import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valo_chat_app/app/routes/app_pages.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/app_binding.dart';
import 'package:valo_chat_app/app/utils/global.dart';
import 'app/routes/routes.dart';
import 'app/utils/storage_service.dart';
import 'package:valo_chat_app/app/lang/lang.dart';

Future main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )); //status bar
    return GetMaterialApp(
      title: 'Valo chat app',
      debugShowCheckedModeBanner: false,
      //Translate language
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      themeMode: LocalStorage().getThemeMode(),
      theme: AppTheme.light, //theme
      darkTheme: AppTheme.dark,
      getPages: AppPages.pages, //routes
      initialRoute: LocalStorage.checkTokenExpire() == false
          ? Routes.WELCOME
          : Routes.HOME,
      initialBinding: AppBinding(),
    );
  }
}
