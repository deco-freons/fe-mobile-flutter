// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadEventModel _$ReadEventModelFromJson(Map<String, dynamic> json) =>
    ReadEventModel(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      todaysDate: json['todaysDate'] as String,
      filter: json['filter'] as Map<String, dynamic>?,
      sort: json['sort'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReadEventModelToJson(ReadEventModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'todaysDate': instance.todaysDate,
      'filter': instance.filter,
      'sort': instance.sort,
    };
