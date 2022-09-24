// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventModel _$CreateEventModelFromJson(Map<String, dynamic> json) =>
    CreateEventModel(
      eventName: json['eventName'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      location: json['location'] as int,
      locationName: json['locationName'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreateEventModelToJson(CreateEventModel instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'categories': instance.categories,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'location': instance.location,
      'locationName': instance.locationName,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
    };
