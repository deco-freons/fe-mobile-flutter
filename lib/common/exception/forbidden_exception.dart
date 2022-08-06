import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ForbiddenException extends BaseException {
  ForbiddenException()
      : super(statusCode: 403, message: "Forbidden");
}