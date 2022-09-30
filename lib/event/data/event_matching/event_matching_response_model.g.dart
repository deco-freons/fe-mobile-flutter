// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_matching_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventMatchingResponseModel _$EventMatchingResponseModelFromJson(
        Map<String, dynamic> json) =>
    EventMatchingResponseModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      distance: (json['distance'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      shortDescription: json['shortDescription'] as String,
      eventCreator: EventParticipantModel.fromJson(
          json['eventCreator'] as Map<String, dynamic>),
      location:
          EventLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      locationName: json['locationName'] as String,
      participants: json['participants'] as int,
      eventStatus: EventStatusModel.fromJson(
          json['eventStatus'] as Map<String, dynamic>),
      eventImage: json['eventImage'] == null
          ? null
          : ImageModel.fromJson(json['eventImage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventMatchingResponseModelToJson(
        EventMatchingResponseModel instance) =>
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
      'participants': instance.participants,
      'eventStatus': instance.eventStatus,
      'eventImage': instance.eventImage,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'shortDescription': instance.shortDescription,
    };
