import 'package:dio/dio.dart';

//Response from api
class NetworkResponse<T> {
  int code;
  bool ok;
  String? msg;
  T? data;
  String? rawBody;

  NetworkResponse({
    required this.code,
    required this.ok,
    this.msg,
    this.data,
    this.rawBody,
  });

  factory NetworkResponse.fromResponse(Response response, fromJson) {
    try {
      return NetworkResponse(
        code: response.statusCode!,
        ok: response.statusCode == 200 ||
            response.statusCode == 201 && response.data != null,
        msg: response.statusMessage ?? '',
        rawBody: response.data.toString(),
        data: response.data == null ? null : fromJson(response.data),
      );
    } catch (e, s) {
      print('decode json error 29: $e');
      print('stacktrace: $s');
      return NetworkResponse.withError(null);
    }
  }

  factory NetworkResponse.withError(Response? response) {
    return NetworkResponse(
      code: response?.statusCode ?? -1,
      ok: false,
      msg: response?.statusMessage,
      data: null,
    );
  }

  @override
  String toString() {
    return 'NetworkResponse{code: $code, ok: $ok, msg: $msg, data: $data, rawBody: $rawBody}';
  }
}
