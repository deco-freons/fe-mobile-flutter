import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_participant_model.g.dart';

@JsonSerializable()
class EventParticipantModel extends BaseModel {
  final int? userID;
  final String username;
  final String firstName;
  final String lastName;
  const EventParticipantModel(
      {required this.username,
      required this.firstName,
      required this.lastName,
      this.userID});

  EventParticipantModel copyWith(
      {int? userID, String? username, String? firstName, String? lastName}) {
    return EventParticipantModel(
        userID: userID ?? this.userID,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName);
  }

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventParticipantModelToJson(this);

  @override
  List<Object> get props => [username];
}