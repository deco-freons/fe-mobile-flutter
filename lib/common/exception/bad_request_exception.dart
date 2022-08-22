import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class BadRequestException extends BaseException {
  BadRequestException([String? message])
      : super(statusCode: 400, message: message ?? "Bad Request");
}
