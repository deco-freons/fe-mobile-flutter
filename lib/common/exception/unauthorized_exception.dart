import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class UnauthorizedException extends BaseException {
  UnauthorizedException()
      : super(statusCode: 401, message: "Unauthorized");
}
