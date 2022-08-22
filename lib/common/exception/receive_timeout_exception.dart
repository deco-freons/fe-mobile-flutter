import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class ReceiveTimeoutException extends BaseException {
  ReceiveTimeoutException()
      : super(
            statusCode: 1,
            message: "Receive timeout in connection with API server");
}
