import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

//Dio
class ConnectService extends DioForNative {
  //Base url
  ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
    options.baseUrl = 'http://172.22.160.1:3000/';
    // options.baseUrl = 'http://10.0.2.2:3000/';
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
  }
}
