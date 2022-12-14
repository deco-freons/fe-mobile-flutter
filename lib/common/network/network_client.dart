import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/common/exception/bad_request_exception.dart';
import 'package:flutter_boilerplate/common/exception/cancelled_exception.dart';
import 'package:flutter_boilerplate/common/exception/connection_timeout_exception.dart';
import 'package:flutter_boilerplate/common/exception/forbidden_exception.dart';
import 'package:flutter_boilerplate/common/exception/internal_error_exception.dart';
import 'package:flutter_boilerplate/common/exception/internet_connection_exception.dart';
import 'package:flutter_boilerplate/common/exception/method_not_allowed_exception.dart';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';
import 'package:flutter_boilerplate/common/exception/receive_timeout_exception.dart';
import 'package:flutter_boilerplate/common/exception/send_timeout_exception.dart';
import 'package:flutter_boilerplate/common/exception/unauthorized_exception.dart';
import 'package:flutter_boilerplate/common/network/network_logging.dart';
import 'package:flutter_boilerplate/common/network/network_refresh.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkClient {
  final Dio dio = Dio(
    BaseOptions(
        baseUrl: "https://deco-freons-be.devs.id",
        connectTimeout: 30000,
        receiveTimeout: 30000,
        contentType: "application/json"),
  )..interceptors.addAll(((dotenv.env['releaseEnv'] == 'prod') |
          (dotenv.env['releaseEnv'] == 'demo'))
      ? [Refresh()]
      : [Logging(), Refresh()]);
  final String env = "DEV";
  final secureStorage = getIt.get<SecureStorage>();

  Future<dynamic> _request({
    required String path,
    required String method,
    Map<String, dynamic>? body,
    bool formData = false,
    bool authorized = false,
  }) async {
    dynamic responseData;

    try {
      dio.options.method = method;
      if (authorized) {
        String? accessToken = await secureStorage.get(key: "accessToken");
        dio.options.headers['Authorization'] = "$accessToken";
      }

      final response = await dio.request(
        path,
        data: body != null
            ? formData
                ? FormData.fromMap(body)
                : json.encode(body)
            : null,
      );
      responseData = response.data;
    } catch (e) {
      if (e is DioError) {
        _handleDioError(e);
      }
      throw InternalServerErrorException();
    }
    return responseData;
  }

  _handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.response:
        _handleResponseError(e.response?.statusCode, e.response?.data);
        break;
      case DioErrorType.cancel:
        throw CancelledException();
      case DioErrorType.connectTimeout:
        throw ConnectionTimeoutException();
      case DioErrorType.receiveTimeout:
        throw ReceiveTimeoutException();
      case DioErrorType.sendTimeout:
        throw SendTimeoutException();
      case DioErrorType.other:
        throw InternetConnectionException();
      default:
        throw InternalServerErrorException();
    }
  }

  _handleResponseError(int? statusCode, dynamic errorData) {
    String? message = errorData['message'];
    switch (statusCode) {
      case 400:
        throw BadRequestException(message);
      case 401:
        throw UnauthorizedException(message);
      case 403:
        throw ForbiddenException(message);
      case 404:
        throw NotFoundException(message);
      case 405:
        throw MethodNotAllowedException(message);
      default:
        throw InternalServerErrorException(message);
    }
  }

  Future<dynamic> get({
    required String path,
    bool formData = false,
    bool authorized = false,
  }) async {
    try {
      return _request(
          path: path,
          method: "GET",
          formData: formData,
          authorized: authorized);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post({
    required String path,
    required Map<String, dynamic> body,
    bool formData = false,
    bool authorized = false,
  }) async {
    try {
      return _request(
          path: path,
          method: "POST",
          body: body,
          formData: formData,
          authorized: authorized);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required String path,
    required Map<String, dynamic> body,
    bool formData = false,
    bool authorized = false,
  }) async {
    try {
      return _request(
          path: path,
          method: "PUT",
          body: body,
          formData: formData,
          authorized: authorized);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch({
    required String path,
    required Map<String, dynamic> body,
    bool formData = false,
    bool authorized = false,
  }) async {
    try {
      return _request(
          path: path,
          method: "PATCH",
          body: body,
          formData: formData,
          authorized: authorized);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String path,
    required Map<String, dynamic> body,
    bool formData = false,
    bool authorized = false,
  }) async {
    try {
      return _request(
          path: path,
          method: "DELETE",
          body: body,
          formData: formData,
          authorized: authorized);
    } catch (e) {
      rethrow;
    }
  }
}
