import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class BadRequestException extends BaseException {
  BadRequestException()
      : super(statusCode: 400, message: "Bad Request");
}
