// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// class NotificationService {
//   //Singleton pattern
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   //instance of FlutterLocalNotificationsPlugin
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('valo.png');

//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );

//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await _configureLocalTimeZone();

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
  
  
// }
// Future<void> _configureLocalTimeZone() async {
//   if (kIsWeb || Platform.isLinux) {
//     return;
//   }
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }