import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

class ConnectService extends DioForNative {
  ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
    //options.baseUrl = 'http://192.168.1.101:3000/';
    options.baseUrl = 'http://10.0.2.2:3000/';
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
  }
}
