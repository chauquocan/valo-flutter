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
    // interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (DioError e, handler)async  {
    //       if(e.response!=null){
    //         if (e.response?.statusCode == 401) {//catch the 401 here
    //         this.interceptors.requestLock.lock();
    //         this.interceptors.responseLock.lock();
    //         RequestOptions requestOptions = e.requestOptions;
    //         await refreshToken();
    //         final opts = new Options(method: requestOptions.method);
    //         this.options.headers["Authorization"] = "Bearer " + accessToken;
    //         this.options.headers["Accept"] = "*/*";
    //         this.interceptors.requestLock.unlock();
    //         this.interceptors.responseLock.unlock();
    //         final response = await this.request(requestOptions.path,
    //             options: opts,
    //             cancelToken: requestOptions.cancelToken,
    //             onReceiveProgress: requestOptions.onReceiveProgress,
    //             data: requestOptions.data,
    //             queryParameters: requestOptions.queryParameters);
    //         if (response != null) {
    //           handler.resolve(response);
    //         } else {
    //           return null;
    //         }
    //       } else {
    //         handler.next(e);
    //       }
    //     }
    //       }
    //   ),
    // );
  }
}
