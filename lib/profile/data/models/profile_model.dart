import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/event_by_user_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/models/user_location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends BaseModel {
  final int userID;
  final String username;
  final String firstName;
  final String lastName;
  final UserLocationModel? location;
  final List<PreferenceModel> preferences;
  final bool isShareLocation;
  final List<EventByUserModel> eventCreated;

  const ProfileModel({
    required this.userID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.preferences,
    required this.isShareLocation,
    required this.eventCreated,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
