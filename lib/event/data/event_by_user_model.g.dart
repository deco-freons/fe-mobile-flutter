// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_by_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventByUserModel _$EventByUserModelFromJson(Map<String, dynamic> json) =>
    EventByUserModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      distance: (json['distance'] as num).toDouble(),
      date: json['date'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      eventImage: json['eventImage'] == null
          ? null
          : EventImageModel.fromJson(
              json['eventImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventByUserModelToJson(EventByUserModel instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'eventName': instance.eventName,
      'distance': instance.distance,
      'date': instance.date,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'eventImage': instance.eventImage,
    };
