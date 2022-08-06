import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/common/exception/bad_request_exception.dart';
import 'package:flutter_boilerplate/common/exception/forbidden_exception.dart';
import 'package:flutter_boilerplate/common/exception/internal_error_exception.dart';
import 'package:flutter_boilerplate/common/exception/method_not_allowed_exception.dart';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';
import 'package:flutter_boilerplate/common/exception/unauthorized_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkClient {
  final Dio dio = Dio();
  final String env = "DEV";

  Future<dynamic> _request({
    required String path,
    required String method,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    dynamic responseData;
    try {
      final url = env == "DEV" ? "http://localhost:8000" : "production";
      final uri = "$url$path";
      final sharedPreferences = await SharedPreferences.getInstance();

      dio.options.method = method;
      dio.options.headers['content-type'] = 'application/json';
      if (authorized) {
        dio.options.headers['Authorization'] =
      "Bearer ${sharedPreferences.getString('token')}";
      }

      final response = await dio.request(
        uri,
        data: formData ? FormData.fromMap(body) : json.encode(body),
      );
      responseData = _response(response);

    } on BadRequestException {
      throw BadRequestException();
    } on ForbiddenException {
      throw ForbiddenException();
    } on InternalServerErrorException {
      throw InternalServerErrorException();
    } on MethodNotAllowedException {
      throw MethodNotAllowedException();
    } on NotFoundException {
      throw NotFoundException();
    } on SocketException {
      throw InternalServerErrorException("No Internet Connection");
    } on UnauthorizedException {
      throw UnauthorizedException();
    }
    return responseData;
  }

  dynamic _response(Response response) {
    switch(response.statusCode) {
      case 200: return response.data;
      case 201: return response.data;
      case 400: throw BadRequestException();
      case 401: throw UnauthorizedException();
      case 403: throw ForbiddenException();
      case 404: throw NotFoundException();
      case 405: throw MethodNotAllowedException();
      case 500: throw InternalServerErrorException(response.data.toString());
      default: throw InternalServerErrorException();
    }
  }

  Future<dynamic> get({
    required String path,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    try {
      return _request(path: path, method: "GET", body: body, formData: formData, authorized: authorized);
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> post({
    required String path,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    try {
      return _request(path: path, method: "POST", body: body, formData: formData, authorized: authorized);
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required String path,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    try {
      return _request(path: path, method: "PUT", body: body, formData: formData, authorized: authorized);
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> patch({
    required String path,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    try {
      return _request(path: path, method: "PATCH", body: body, formData: formData, authorized: authorized);
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> delete({
    required String path,
    required Map<String, dynamic> body,
    bool formData = true,
    bool authorized = false,
  }) async {
    try {
      return _request(path: path, method: "DELETE", body: body, formData: formData, authorized: authorized);
    } catch(e) {
      rethrow;
    }
  }
}