// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_radius_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRadiusModel _$EventRadiusModelFromJson(Map<String, dynamic> json) =>
    EventRadiusModel(
      radius: json['radius'] as int,
      isMoreOrLess: json['isMoreOrLess'] as String,
    );

Map<String, dynamic> _$EventRadiusModelToJson(EventRadiusModel instance) =>
    <String, dynamic>{
      'radius': instance.radius,
      'isMoreOrLess': instance.isMoreOrLess,
    };
