import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/participant_location_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_participant_model.g.dart';

@JsonSerializable()
class EventParticipantModel extends BaseModel {
  final int? userID;
  final String username;
  final String firstName;
  final String lastName;
  final ParticipantLocationModel? location;
  final bool? isShareLocation;
  final ImageModel? userImage;

  const EventParticipantModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    this.isShareLocation,
    this.userID,
    this.location,
    this.userImage,
  });

  const EventParticipantModel.empty({
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    this.userID = 0,
    this.location,
    this.isShareLocation = false,
    this.userImage,
  });

  EventParticipantModel copyWith(
      {int? userID,
      String? username,
      String? firstName,
      String? lastName,
      ParticipantLocationModel? location,
      bool? isShareLocation,
      ImageModel? userImage}) {
    return EventParticipantModel(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      isShareLocation: isShareLocation ?? this.isShareLocation,
      userImage: userImage ?? this.userImage,
    );
  }

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventParticipantModelToJson(this);

  @override
  List<Object> get props => [username];
}
