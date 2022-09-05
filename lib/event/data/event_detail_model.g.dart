// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailModel _$EventDetailModelFromJson(Map<String, dynamic> json) =>
    EventDetailModel(
      eventID: json['eventID'] as int,
      eventName: json['eventName'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => PreferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      description: json['description'] as String,
      eventCreator: EventParticipantModel.fromJson(
          json['eventCreator'] as Map<String, dynamic>),
      participants: json['participants'] as int,
      participantsList: (json['participantsList'] as List<dynamic>)
          .map((e) => EventParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      participated: json['participated'] as bool,
      locationName: json['locationName'] as String,
      location:
          EventLocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailModelToJson(EventDetailModel instance) =>
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
      'eventCreator': instance.eventCreator,
      'participants': instance.participants,
      'participantsList': instance.participantsList,
      'participated': instance.participated,
      'location': instance.location,
      'locationName': instance.locationName,
    };
