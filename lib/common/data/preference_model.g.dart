// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceModel _$PreferenceModelFromJson(Map<String, dynamic> json) =>
    PreferenceModel(
      preferenceList: (json['preferenceList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PreferenceModelToJson(PreferenceModel instance) =>
    <String, dynamic>{
      'preferenceList': instance.preferenceList,
    };
