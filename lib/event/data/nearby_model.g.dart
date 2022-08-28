// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyModel _$NearbyModelFromJson(Map<String, dynamic> json) => NearbyModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
    );

Map<String, dynamic> _$NearbyModelToJson(NearbyModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'radius': instance.radius,
    };
