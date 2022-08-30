// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditEventModel _$EditEventModelFromJson(Map<String, dynamic> json) =>
    EditEventModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$EditEventModelToJson(EditEventModel instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'eventName': instance.eventName,
      'categories': instance.categories,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'description': instance.description,
    };
