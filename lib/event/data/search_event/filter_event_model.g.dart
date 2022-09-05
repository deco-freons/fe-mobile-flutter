// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEventModel _$FilterEventModelFromJson(Map<String, dynamic> json) =>
    FilterEventModel(
      eventCategories: json['eventCategories'] as Map<String, dynamic>?,
      eventRadius: json['eventRadius'] as Map<String, dynamic>?,
      daysToEvent: json['daysToEvent'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FilterEventModelToJson(FilterEventModel instance) =>
    <String, dynamic>{
      'eventCategories': instance.eventCategories,
      'eventRadius': instance.eventRadius,
      'daysToEvent': instance.daysToEvent,
    };
