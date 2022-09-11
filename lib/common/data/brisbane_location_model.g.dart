// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brisbane_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrisbaneLocationModel _$BrisbaneLocationModelFromJson(
        Map<String, dynamic> json) =>
    BrisbaneLocationModel(
      location_id: json['location_id'] as int,
      suburb: json['suburb'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$BrisbaneLocationModelToJson(
        BrisbaneLocationModel instance) =>
    <String, dynamic>{
      'location_id': instance.location_id,
      'suburb': instance.suburb,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
