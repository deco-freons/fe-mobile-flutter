import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/event_by_user_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:flutter_boilerplate/user/data/common/user_location_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'other_user_model.g.dart';

@JsonSerializable()
class OtherUserModel extends BaseModel {
  final int userID;
  final String username;
  final String firstName;
  final String lastName;
  final UserLocationModel? location;
  final List<PreferenceModel> preferences;
  final bool isShareLocation;
  final List<EventByUserModel> eventCreated;
  final ImageModel? userImage;

  const OtherUserModel({
    required this.userID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.preferences,
    required this.isShareLocation,
    required this.eventCreated,
    this.userImage,
  });

  factory OtherUserModel.fromJson(Map<String, dynamic> json) =>
      _$OtherUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserModelToJson(this);
}
