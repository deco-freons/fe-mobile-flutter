import 'package:flutter_boilerplate/common/data/base_model.dart';

class RegisterModel implements BaseModel {
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime birthDate;

  RegisterModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.birthDate});
}
