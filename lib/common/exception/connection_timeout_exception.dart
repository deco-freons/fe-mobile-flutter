import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ConnectionTimeoutException extends BaseException {
  ConnectionTimeoutException()
      : super(statusCode: 1, message: "Connection to API server timed out");
}
