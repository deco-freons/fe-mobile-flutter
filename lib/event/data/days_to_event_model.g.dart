// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days_to_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaysToEventModel _$DaysToEventModelFromJson(Map<String, dynamic> json) =>
    DaysToEventModel(
      days: json['days'] as int,
      isMoreOrLess: json['isMoreOrLess'] as String,
    );

Map<String, dynamic> _$DaysToEventModelToJson(DaysToEventModel instance) =>
    <String, dynamic>{
      'days': instance.days,
      'isMoreOrLess': instance.isMoreOrLess,
    };
