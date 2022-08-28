// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      date: json['date'] as String,
      distance: (json['distance'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      eventCreator: Map<String, String>.from(json['eventCreator'] as Map),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'eventName': instance.eventName,
      'date': instance.date,
      'distance': instance.distance,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'eventCreator': instance.eventCreator,
    };
