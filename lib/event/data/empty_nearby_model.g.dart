// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_nearby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyNearbyModel _$EmptyNearbyModelFromJson(Map<String, dynamic> json) =>
    EmptyNearbyModel(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
    );

Map<String, dynamic> _$EmptyNearbyModelToJson(EmptyNearbyModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'radius': instance.radius,
    };
