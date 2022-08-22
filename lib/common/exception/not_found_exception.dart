import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class NotFoundException extends BaseException {
  NotFoundException([String? message])
      : super(statusCode: 404, message: message ?? "Not Found");
}
