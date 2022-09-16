// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_event_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularEventLocationModel _$PopularEventLocationModelFromJson(
        Map<String, dynamic> json) =>
    PopularEventLocationModel(
      suburb: json['suburb'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$PopularEventLocationModelToJson(
        PopularEventLocationModel instance) =>
    <String, dynamic>{
      'suburb': instance.suburb,
      'city': instance.city,
      'state': instance.state,
    };
