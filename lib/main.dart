import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/routes/app_pages.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/app_binding.dart';
import 'app/routes/routes.dart';
import 'app/utils/store_service.dart';
import 'package:valo_chat_app/app/lang/lang.dart';

Future main() async {
  await dotenv.load(fileName: ".env"); // dotenv
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //firebase auth
  await Storage.init(); //storage service
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.blue),
    ); //status bar
    print('current id: ${Storage.getUser()?.id}'); //current user store in local
    return GetMaterialApp(
      title: 'Valo chat app',
      debugShowCheckedModeBanner: false,
      //Translate language
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      //Theme
      theme: AppTheme.light,
      //Routes
      getPages: AppPages.pages,
      initialRoute:
          Storage.ExpireToken() == false ? Routes.WELCOME : Routes.HOME,
      initialBinding: AppBinding(),
    );
  }
}
