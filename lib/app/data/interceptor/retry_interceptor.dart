import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  static var baseUrl = dotenv.env['BASE_URL'].toString();
  final AuthProvider authProvider;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
    required this.authProvider,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        throw Exception(e);
      }
    }
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      try {
        final response = await authProvider.refreshToken();
        if (response.ok) {
          await LocalStorage.saveToken(response.data!);
          err.requestOptions.headers["Authorization"] =
              "Bearer" + response.data!.accessToken.toString();
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );
          var newbaseOps = BaseOptions(
            baseUrl: baseUrl,
            contentType: 'application/json; charset=utf-8',
            connectTimeout: 3000,
            receiveTimeout: 5000,
            responseType: ResponseType.json,
          );
          final clonnReq = await Dio(newbaseOps).request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters);
          return handler.resolve(clonnReq);
        }
      } catch (e) {}
    }
    handler.next(err);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}
