// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUserModel _$EditUserModelFromJson(Map<String, dynamic> json) =>
    EditUserModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthDate: json['birthDate'] as String,
      preferences: (json['preferences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EditUserModelToJson(EditUserModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'preferences': instance.preferences,
    };
