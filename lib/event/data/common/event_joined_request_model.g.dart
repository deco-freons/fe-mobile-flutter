// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_joined_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventJoinedRequestModel _$EventJoinedRequestModelFromJson(
        Map<String, dynamic> json) =>
    EventJoinedRequestModel(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      filter: EventFilterModel.fromJson(json['filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventJoinedRequestModelToJson(
        EventJoinedRequestModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'filter': instance.filter,
    };
