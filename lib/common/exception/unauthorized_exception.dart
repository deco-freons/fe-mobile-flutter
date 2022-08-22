import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class UnauthorizedException extends BaseException {
  UnauthorizedException([String? message])
      : super(statusCode: 401, message: message ?? "Unauthorized");
}
