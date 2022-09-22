import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/models/user_location_model.dart';
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
  final UserLocationModel location;
  final bool isShareLocation;
  final ImageModel? userImage;

  const UserModel(
      {required this.isVerified,
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
      this.userImage});

  UserModel copyWith({
    int? userID,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? birthDate,
    bool? isVerified,
    bool? isFirstLogin,
    List<PreferenceModel>? preferences,
    UserLocationModel? location,
    bool? isShareLocation,
    ImageModel? userImage,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      isVerified: isVerified ?? this.isVerified,
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      preferences: preferences ?? this.preferences,
      location: location ?? this.location,
      isShareLocation: isShareLocation ?? this.isShareLocation,
      userImage: userImage ?? this.userImage,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object> get props => [userID];
}
