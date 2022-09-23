// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      userID: json['userID'] as int,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      location: json['location'] == null
          ? null
          : UserLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => PreferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isShareLocation: json['isShareLocation'] as bool,
      eventCreated: (json['eventCreated'] as List<dynamic>)
          .map((e) => EventByUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userImage: json['userImage'] == null
          ? null
          : ImageModel.fromJson(json['userImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'location': instance.location,
      'preferences': instance.preferences,
      'isShareLocation': instance.isShareLocation,
      'eventCreated': instance.eventCreated,
      'userImage': instance.userImage,
    };
