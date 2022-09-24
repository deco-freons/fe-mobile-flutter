// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUserModelResponse _$EditUserModelResponseFromJson(
        Map<String, dynamic> json) =>
    EditUserModelResponse(
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => PreferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userID: json['userID'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: json['birthDate'] as String,
      location:
          UserLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      isShareLocation: json['isShareLocation'] as bool,
      userImage: json['userImage'] == null
          ? null
          : ImageModel.fromJson(json['userImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditUserModelResponseToJson(
        EditUserModelResponse instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'preferences': instance.preferences,
      'location': instance.location,
      'isShareLocation': instance.isShareLocation,
      'userImage': instance.userImage,
    };
