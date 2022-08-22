import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class CancelledException extends BaseException {
  CancelledException()
      : super(statusCode: 1, message: "Request to API server was cancelled");
}
