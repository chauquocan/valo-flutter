import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

//Dio
// class ConnectService extends DioForNative {
//   static var baseUrl = dotenv.env['BASE_URL'];
//   //Base url
//   ConnectService([BaseOptions? baseOptions]) : super(baseOptions) {
//     options.baseUrl = '${baseUrl}';
//     options.contentType = Headers.jsonContentType;
//     options.connectTimeout = 2000 * 60;
//     options.receiveTimeout = 2000 * 60;
//     interceptors.add(
//       RetryOnConnectionChangeInterceptor(
//         requestRetrier: DioConnectivityRequestRetrier(
//           dio: this,
//           connectivity: Connectivity(),
//         ),
//       ),
//     );
//     // interceptors.add(
//     //   InterceptorsWrapper(
//     //     onError: (DioError e, handler)async  {
//     //       if(e.response!=null){
//     //         if (e.response?.statusCode == 401) {//catch the 401 here
//     //         this.interceptors.requestLock.lock();
//     //         this.interceptors.responseLock.lock();
//     //         RequestOptions requestOptions = e.requestOptions;
//     //         await refreshToken();
//     //         final opts = new Options(method: requestOptions.method);
//     //         this.options.headers["Authorization"] = "Bearer " + accessToken;
//     //         this.options.headers["Accept"] = "*/*";
//     //         this.interceptors.requestLock.unlock();
//     //         this.interceptors.responseLock.unlock();
//     //         final response = await this.request(requestOptions.path,
//     //             options: opts,
//     //             cancelToken: requestOptions.cancelToken,
//     //             onReceiveProgress: requestOptions.onReceiveProgress,
//     //             data: requestOptions.data,
//     //             queryParameters: requestOptions.queryParameters);
//     //         if (response != null) {
//     //           handler.resolve(response);
//     //         } else {
//     //           return null;
//     //         }
//     //       } else {
//     //         handler.next(e);
//     //       }
//     //     }
//     //       }
//     //   ),
//     // );
//   }
// }

class ConnectService {
  static final ConnectService _instance = ConnectService._internal();
  static var baseUrl = dotenv.env['BASE_URL'].toString();
  factory ConnectService() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  ConnectService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json; charset=utf-8',
      connectTimeout: 2000 * 60,
      receiveTimeout: 2000 * 60,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      requestRetrier: DioConnectivityRequestRetrier(
        dio: dio,
        connectivity: Connectivity(),
      ),
    ));
  }

  ///token
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers;
    String? token = Storage.getToken()?.accessToken;
    if (token != null) {
      headers = {
        'Authorization': 'Bearer $token',
      };
    }
    return headers;
  }

  /// restful get
  Future get(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
    return response;
  }

  /// restful post
  Future post(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response;
  }

  /// restful put
  Future put(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response;
  }

  /// restful patch
  Future patch(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);

    return response;
  }

  /// restful delete
  Future delete(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response;
  }

  /// restful post
  Future postForm(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response;
  }

/*
   * error
   */
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }

      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response?.statusCode;
            if (errCode == null) {
              return ErrorEntity(code: -2, message: error.message);
            }
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.data['message'] ?? "请求语法错误");
                }

              case 401:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.data['message'] ?? "没有权限");
                }

              case 403:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.data['message'] ?? "服务器拒绝执行");
                }
              case 404:
                {
                  return ErrorEntity(code: errCode, message: "无法连接服务器");
                }
              case 405:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.data['message'] ?? "请求方法被禁止");
                }
              case 500:
                {
                  return ErrorEntity(code: errCode, message: "服务器内部错误");
                }
              case 502:
                {
                  return ErrorEntity(code: errCode, message: "无效的请求");
                }
              case 503:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.data['message'] ?? "服务器挂了");
                }
              case 505:
                {
                  return ErrorEntity(
                      code: errCode,
                      message:
                          error.response?.data['message'] ?? "不支持HTTP协议请求");
                }
              default:
                {
                  return ErrorEntity(
                      code: errCode, message: error.response?.data['message']);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }
}

class ErrorEntity implements Exception {
  int code;
  String? message;
  ErrorEntity({required this.code, this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}
