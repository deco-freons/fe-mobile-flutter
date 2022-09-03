// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      isVerified: json['isVerified'] as bool,
      isFirstLogin: json['isFirstLogin'] as bool,
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => PreferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userID: json['userID'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: json['birthDate'] as String,
      location: json['location'] as String?,
      isShareLocation: json['isShareLocation'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'isVerified': instance.isVerified,
      'isFirstLogin': instance.isFirstLogin,
      'preferences': instance.preferences,
      'location': instance.location,
      'isShareLocation': instance.isShareLocation,
    };
