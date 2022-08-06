import 'package:flutter_boilerplate/common/exception/base_exception.dart';

class NotFoundException extends BaseException {
  NotFoundException()
      : super(statusCode: 404, message: "Not Found");
}
