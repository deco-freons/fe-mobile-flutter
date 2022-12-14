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
      location: json['location'] as int,
      locationName: json['locationName'] as String,
      shortDescription: json['shortDescription'] as String,
      description: json['description'] as String,
      eventStatus: json['eventStatus'] as String,
      eventPrice: EventPriceRequestModel.fromJson(
          json['eventPrice'] as Map<String, dynamic>),
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
      'location': instance.location,
      'locationName': instance.locationName,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'eventStatus': instance.eventStatus,
      'eventPrice': instance.eventPrice.toJson(),
    };
