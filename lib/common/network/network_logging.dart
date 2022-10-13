// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (dotenv.env['releaseEnv'] == 'dev') {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (dotenv.env['releaseEnv'] == 'dev') {
      print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (dotenv.env['releaseEnv'] == 'dev') {
      print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
    }
    return super.onError(err, handler);
  }
}
