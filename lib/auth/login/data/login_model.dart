import 'package:flutter_boilerplate/common/data/base_model.dart';

class LoginModel implements BaseModel {
  String username;
  String password;

  LoginModel({
    required this.username,
    required this.password,
  });
}
