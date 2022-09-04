import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
<<<<<<< HEAD
import 'package:flutter_boilerplate/user/data/models/location_model.dart';
=======
import 'package:flutter_boilerplate/user/data/user_location_model.dart';
>>>>>>> deb8e04 (feat: :construction: integrate ui with bloc)
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
<<<<<<< HEAD
  final LocationModel location;
=======
  final UserLocationModel? location;
>>>>>>> deb8e04 (feat: :construction: integrate ui with bloc)
  final bool isShareLocation;

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
    required this.location,
    required this.isShareLocation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object> get props => [userID];
}
