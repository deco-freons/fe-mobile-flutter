// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_joined_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventJoinedModel _$EventJoinedModelFromJson(Map<String, dynamic> json) =>
    EventJoinedModel(
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
      eventImage: json['eventImage'] == null
          ? null
          : ImageModel.fromJson(json['eventImage'] as Map<String, dynamic>),
      participantsList: (json['participantsList'] as List<dynamic>)
          .map((e) => EventParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEventCreator: json['isEventCreator'] as bool,
      eventPrice: EventPriceResponseModel.fromJson(
          json['eventPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventJoinedModelToJson(EventJoinedModel instance) =>
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
      'participantsList': instance.participantsList,
      'isEventCreator': instance.isEventCreator,
    };
