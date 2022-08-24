import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  final int userID;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String birthDate;
  final bool isVerified;
  final bool isFirstLogin;
  final List<PreferenceModel> preferences;

  const UserModel({
    required this.isVerified,
    required this.isFirstLogin,
    required this.preferences,
    required this.userID,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object> get props => [userID];
}
