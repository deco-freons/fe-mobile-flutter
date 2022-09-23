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
      isShareLocation: json['isShareLocation'] as bool?,
      userID: json['userID'] as int?,
      location: json['location'] == null
          ? null
          : ParticipantLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
      userImage: json['userImage'] == null
          ? null
          : ImageModel.fromJson(json['userImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventParticipantModelToJson(
        EventParticipantModel instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'location': instance.location,
      'isShareLocation': instance.isShareLocation,
      'userImage': instance.userImage,
    };
