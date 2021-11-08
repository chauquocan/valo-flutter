import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Dio
class ConnectService extends DioForNative {
  static var baseUrl = dotenv.env['BASE_URL'];
  //Base url
  ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
    options.baseUrl = '${baseUrl}';
    // options.baseUrl = 'http://ec2-3-0-183-214.ap-southeast-1.compute.amazonaws.com:3000/';
    // options.baseUrl = 'http://10.0.2.2:3000/';
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
  }
}
