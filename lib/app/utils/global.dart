import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class Global {
  static Future init() async {
    await dotenv.load(fileName: ".env"); // dotenv
    await LocalStorage.init();
    await Firebase.initializeApp(); //firebase auth
    WidgetsFlutterBinding.ensureInitialized();
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: '_message',
        channelName: 'Inbox message',
        channelDescription: 'chat',
        enableVibration: true,
        importance: NotificationImportance.High,
      )
    ]);
    ConnectService();
  }
}
