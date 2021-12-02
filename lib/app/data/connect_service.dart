import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

//Dio api service
class ConnectService {
  static var baseUrl = dotenv.env['BASE_URL'].toString();

  static final ConnectService _instance = ConnectService._internal();
  factory ConnectService() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  ConnectService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json; charset=utf-8',
      connectTimeout: 3000,
      receiveTimeout: 5000,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      authProvider: AuthProvider(),
      requestRetrier: DioConnectivityRequestRetrier(
        dio: dio,
        connectivity: Connectivity(),
      ),
    ));
  }

  ///token
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers;
    var token = LocalStorage.getToken()?.accessToken.toString();
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

  Future postRefreshToken(String path,
      {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(path, data: params, options: requestOptions);
    return response;
  }
}
