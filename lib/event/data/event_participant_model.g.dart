// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventParticipantModel _$EventParticipantModelFromJson(
        Map<String, dynamic> json) =>
    EventParticipantModel(
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userID: json['userID'] as int?,
    );

Map<String, dynamic> _$EventParticipantModelToJson(
        EventParticipantModel instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
