import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class InternalServerErrorException extends BaseException {
  InternalServerErrorException([String? message])
      : super(statusCode: 500, message: message ?? "Internal Server Error");
}
