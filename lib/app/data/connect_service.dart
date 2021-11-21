import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'interceptor/interceptors.dart';

//Dio
class ConnectService extends DioForNative {
  static var baseUrl = dotenv.env['BASE_URL'];
  //Base url
  ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
    options.baseUrl = '${baseUrl}';
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
    CustomInterceptors refreshFlow = CustomInterceptors(this);
    interceptors.add(refreshFlow);
  }
}
