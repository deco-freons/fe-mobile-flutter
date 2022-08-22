import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ErrorHandler {
  static String handle(Object e) =>
      e is BaseException ? e.message : e.toString();
}
