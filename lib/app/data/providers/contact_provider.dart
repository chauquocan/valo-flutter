import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/connect_service.dart';
import 'package:valo_chat_app/app/data/models/contact_model.dart';
import 'package:valo_chat_app/app/data/models/network_response.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ContactProvider extends ConnectService {
  //end point

  static const String getFriendsUrl = '/friends';

  //curent userId
  final _userId = Storage.getUser()?.id;

  //Get frineds
  Future<NetworkResponse<ContactPage>> getFriends() async {
    try {
      final response = await get(
        '${getFriendsUrl}',
        options: Options(headers: {
          'Authorization': 'Bearer ${Storage.getToken()!.accessToken}'
        }),
      );
      return NetworkResponse.fromResponse(
        response,
        (json) => ContactPage.fromJson(json),
      );
    } on DioError catch (e, s) {
      throw Exception("$e///////////$s");
    }
  }
}
