import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel implements BaseModel {
  String username;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String birthDate;

  RegisterModel(
      {required this.username,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.birthDate});

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  @override
  List<Object?> get props => [];
}
