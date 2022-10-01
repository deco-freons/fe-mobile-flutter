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
      eventCreator: EventParticipantModel.fromJson(
          json['eventCreator'] as Map<String, dynamic>),
      location:
          EventLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      locationName: json['locationName'] as String,
      participants: json['participants'] as int,
      eventStatus: EventStatusModel.fromJson(
          json['eventStatus'] as Map<String, dynamic>),
      eventPrice: EventPriceResponseModel.fromJson(
          json['eventPrice'] as Map<String, dynamic>),
      eventImage: json['eventImage'] == null
          ? null
          : ImageModel.fromJson(json['eventImage'] as Map<String, dynamic>),
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
      'location': instance.location,
      'locationName': instance.locationName,
      'participants': instance.participants,
      'eventStatus': instance.eventStatus,
      'eventPrice': instance.eventPrice,
      'eventImage': instance.eventImage,
    };
