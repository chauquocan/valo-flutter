import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../data/models/user.dart';

//Storage service for storing local data
class Storage {
  Storage._();

  static late SharedPreferences _pref;
  //init
  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  //save token
  static Future saveToken(LoginRespone user) async {
    await _pref.setString('token', user.toRawJson());
  }

  //get token
  static LoginRespone? getToken() {
    final raw = _pref.getString('token');
    if (raw == null) return null;
    return LoginRespone.fromRawJson(raw);
  }

  //save user
  static Future saveUser(ProfileResponse user) async {
    await _pref.setString('user', user.toRawJson());
  }

  //get user
  static ProfileResponse? getUser() {
    final raw = _pref.getString('user');
    if (raw == null) return null;
    return ProfileResponse.fromRawJson(raw);
  }

  //check token is expired
  static bool ExpireToken() {
    if (getToken() != null) {
      String token = Storage.getToken()!.accessToken.toString();
      bool isExpire = Jwt.isExpired(token);
      if (!isExpire) {
        return true;
      } else {
        _pref.remove('user');
        _pref.remove('token');
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
