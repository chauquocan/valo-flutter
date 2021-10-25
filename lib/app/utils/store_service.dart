import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../data/models/user.dart';

class Storage {
  Storage._();

  static late SharedPreferences _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future saveUser(UserModel user) async {
    await _pref.setString('user', user.toRawJson());
  }

  static UserModel? getUser() {
    final raw = _pref.getString('user');
    if (raw == null) return null;
    return UserModel.fromRawJson(raw);
  }

//check token is expired
  static bool ExpireToken() {
    if (getUser() != null) {
      String token = Storage.getUser()!.accessToken.toString();
      bool isExpire = Jwt.isExpired(token);
      if (!isExpire) {
        return true;
      } else {
        _pref.remove('user');
        return false;
      }
    }
    return false;
  }

  //Log out
  static Future logout() async {
    await _pref.clear();
  }
}
