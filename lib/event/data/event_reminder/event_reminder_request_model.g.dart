// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_reminder_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventReminderRequestModel _$EventReminderRequestModelFromJson(
        Map<String, dynamic> json) =>
    EventReminderRequestModel(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      todaysDate: json['todaysDate'] as String,
      filter: EventFilterModel.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventReminderRequestModelToJson(
        EventReminderRequestModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'todaysDate': instance.todaysDate,
      'filter': instance.filter.toJson(),
    };
