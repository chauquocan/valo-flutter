import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';

Connectivity connectivity = Connectivity();

class CustomInterceptors extends InterceptorsWrapper {
  late Dio previous;
  Dio refreshDio = Dio();

  CustomInterceptors(previous) {
    this.previous = previous;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return super.onRequest(options, handler);
  }

  // 200 && 201 OK
  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.error != null && err.error is SocketException;
  }

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription streamSubscription =
        connectivity.onConnectivityChanged.listen(null);
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(
            refreshDio.request(requestOptions.path,
                cancelToken: requestOptions.cancelToken,
                data: requestOptions.data,
                onReceiveProgress: requestOptions.onReceiveProgress,
                onSendProgress: requestOptions.onSendProgress,
                queryParameters: requestOptions.queryParameters,
                options: Options(
                    method: requestOptions.method,
                    sendTimeout: requestOptions.sendTimeout,
                    receiveTimeout: requestOptions.receiveTimeout,
                    extra: requestOptions.extra,
                    headers: requestOptions.headers,
                    responseType: requestOptions.responseType,
                    contentType: requestOptions.contentType,
                    validateStatus: requestOptions.validateStatus,
                    receiveDataWhenStatusError:
                        requestOptions.receiveDataWhenStatusError,
                    followRedirects: requestOptions.followRedirects,
                    maxRedirects: requestOptions.maxRedirects,
                    requestEncoder: requestOptions.requestEncoder,
                    responseDecoder: requestOptions.responseDecoder,
                    listFormat: requestOptions.listFormat)),
          );
        }
      },
    );

    return responseCompleter.future;
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    print(error.error);
    if (_shouldRetry(error)) {
      try {
        return scheduleRequestRetry(error.requestOptions);
      } catch (e) {
        return e;
      }
    }
    if (error.response?.statusCode == 403 ||
        error.response?.statusCode == 401) {
      AuthProvider auth = AuthProvider();
      await auth.refreshToken();
    }
    // return error;
    print(
        'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
    return super.onError(error, handler);
  }
}
