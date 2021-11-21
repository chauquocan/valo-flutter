import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

//Dio
class ConnectService extends DioForNative {
  static var baseUrl = dotenv.env['BASE_URL'];
  //Base url
  ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
    options.baseUrl = '${baseUrl}';
    options.contentType = Headers.jsonContentType;
    options.connectTimeout = 5000;
    options.receiveTimeout = 3000;
    interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: this,
          connectivity: Connectivity(),
        ),
      ),
    );
  }
}
