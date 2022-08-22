import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class SendTimeoutException extends BaseException {
  SendTimeoutException()
      : super(
            statusCode: 1,
            message: "Send timeout in connection with API server");
}
