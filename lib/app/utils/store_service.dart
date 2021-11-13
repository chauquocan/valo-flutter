import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:valo_chat_app/app/data/models/auth_model.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import '../data/models/profile_model.dart';

//Storage service for storing local data
class Storage {
  Storage._();
  static late ProfileProvider _userProvider;
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
  static Future saveUser(Profile user) async {
    await _pref.setString('user', user.toRawJson());
  }

  static Future updateUser(Profile user) async {
    _pref.remove('user');
    await _pref.setString('user', user.toRawJson());
  }

  //get user
  static Profile? getUser() {
    final raw = _pref.getString('user');
    if (raw == null) return null;
    return Profile.fromRawJson(raw);
  }

  //check token is expired
  static bool ExpireToken() {
    if (getToken() != null) {
      String token = Storage.getToken()!.accessToken.toString();
      // String rfToken = Storage.getToken()!.refreshToken.toString();
      bool isExpire = Jwt.isExpired(token);
      // bool refresh = Jwt.isExpired(rfToken);
      if (!isExpire) {
        return true;
      }
      // else if (isExpire && !refresh) {
      //   final map = {'refreshToken': rfToken};
      //   final refreshResponse = await _userProvider.refreshToken(map);
      //   if (refreshResponse.ok) {
      //   print('token refreshed');
      //     await Storage.saveToken(refreshResponse.data!);
      //     return true;
      //   }
      // }
      else {
        print('token expired');
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
