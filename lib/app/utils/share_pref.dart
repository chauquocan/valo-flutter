import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user.dart';

class SharePref {
  SharePref._();

  static late SharedPreferences _pref;

  static Future initial() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future saveUser(User user) async {
    await _pref.setString('user', user.toRawJson());
  }

  static User? getUser() {
    final raw = _pref.getString('user');
    if (raw == null) return null;
    return User.fromRawJson(raw);
  }

  static Future logout() async {
    await _pref.clear();
  }
}
