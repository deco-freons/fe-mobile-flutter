// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularEventModel _$PopularEventModelFromJson(Map<String, dynamic> json) =>
    PopularEventModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      date: json['date'] as String,
      distance: (json['distance'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      eventCreator: EventParticipantModel.fromJson(
          json['eventCreator'] as Map<String, dynamic>),
      location: PopularEventLocationModel.fromJson(
          json['location'] as Map<String, dynamic>),
      locationName: json['locationName'] as String,
    );

Map<String, dynamic> _$PopularEventModelToJson(PopularEventModel instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'eventName': instance.eventName,
      'date': instance.date,
      'distance': instance.distance,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'eventCreator': instance.eventCreator,
      'location': instance.location,
      'locationName': instance.locationName,
    };
