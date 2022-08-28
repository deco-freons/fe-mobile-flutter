import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ErrorHandler {
  static String handle(Object e) =>
      e is BaseException ? e.message : e.toString();

  static BaseException handleWithStatusCode(Object e) => e is BaseException
      ? e
      : BaseException(statusCode: 1, message: e.toString());
}
