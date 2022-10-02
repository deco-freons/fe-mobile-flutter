// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFilterModel _$EventFilterModelFromJson(Map<String, dynamic> json) =>
    EventFilterModel(
      eventCategories: json['eventCategories'] == null
          ? null
          : EventCategoriesModel.fromJson(
              json['eventCategories'] as Map<String, dynamic>),
      eventRadius: json['eventRadius'] == null
          ? null
          : EventRadiusModel.fromJson(
              json['eventRadius'] as Map<String, dynamic>),
      daysToEvent: json['daysToEvent'] == null
          ? null
          : DaysToEventModel.fromJson(
              json['daysToEvent'] as Map<String, dynamic>),
      eventParticipants: json['eventParticipants'] == null
          ? null
          : ParticipantSizeModel.fromJson(
              json['eventParticipants'] as Map<String, dynamic>),
      eventStatus: json['eventStatus'] == null
          ? null
          : EventStatusRequestModel.fromJson(
              json['eventStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventFilterModelToJson(EventFilterModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eventCategories', instance.eventCategories);
  writeNotNull('eventRadius', instance.eventRadius);
  writeNotNull('daysToEvent', instance.daysToEvent);
  writeNotNull('eventStatus', instance.eventStatus);
  writeNotNull('eventParticipants', instance.eventParticipants);
  return val;
}
