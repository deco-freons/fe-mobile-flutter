// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantSizeModel _$ParticipantSizeModelFromJson(
        Map<String, dynamic> json) =>
    ParticipantSizeModel(
      participants: json['participants'] as int,
      isMoreOrLess: json['isMoreOrLess'] as String,
    );

Map<String, dynamic> _$ParticipantSizeModelToJson(
        ParticipantSizeModel instance) =>
    <String, dynamic>{
      'participants': instance.participants,
      'isMoreOrLess': instance.isMoreOrLess,
    };
