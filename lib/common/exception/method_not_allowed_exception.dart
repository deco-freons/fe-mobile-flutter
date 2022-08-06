import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class MethodNotAllowedException extends BaseException {
  MethodNotAllowedException()
      : super(statusCode: 405, message: "Method Not Allowed");
}
