import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class MethodNotAllowedException extends BaseException {
  MethodNotAllowedException([String? message])
      : super(statusCode: 405, message: message ?? "Method Not Allowed");
}
