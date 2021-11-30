import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en.dart';
import 'vi.dart';

//Translate Service
class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('vi_VN');
  //languages
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };
}
