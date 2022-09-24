import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel extends BaseModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String birthDate;
  final int location;
  final bool isShareLocation;

  const RegisterModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.birthDate,
    required this.location,
    required this.isShareLocation,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
