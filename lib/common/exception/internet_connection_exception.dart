import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class InternetConnectionException extends BaseException {
  InternetConnectionException()
      : super(statusCode: 1, message: "No Internet Connection");
}
