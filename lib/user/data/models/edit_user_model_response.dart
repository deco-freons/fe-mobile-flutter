import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/models/user_location_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_model_response.g.dart';

@JsonSerializable()
class EditUserModelResponse extends BaseModel {
  final int userID;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String birthDate;
  final List<PreferenceModel> preferences;
  final UserLocationModel location;
  final bool isShareLocation;
  final ImageModel? userImage;

  const EditUserModelResponse({
    required this.preferences,
    required this.userID,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.location,
    required this.isShareLocation,
    this.userImage,
  });

  factory EditUserModelResponse.fromJson(Map<String, dynamic> json) =>
      _$EditUserModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserModelResponseToJson(this);

  @override
  List<Object> get props => [userID];
}
