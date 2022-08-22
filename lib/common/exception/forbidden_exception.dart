import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ForbiddenException extends BaseException {
  ForbiddenException([String? message])
      : super(statusCode: 403, message: message ?? "Forbidden");
}
