import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../data/models/user.dart';

class SharePref {
  SharePref._();

  static late SharedPreferences _pref;

  static Future init() async {
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

  static bool validExpire() {
    if (getUser() != null) {
      String token = SharePref.getUser()!.accessToken.toString();
      bool isExpire = Jwt.isExpired(token);
      if (!isExpire) {
        return true;
      }
    }
    return false;
  }

  static Future logout() async {
    await _pref.clear();
  }
}
