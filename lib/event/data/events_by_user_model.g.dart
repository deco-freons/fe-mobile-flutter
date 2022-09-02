// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_by_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsByUserModel _$EventsByUserModelFromJson(Map<String, dynamic> json) =>
    EventsByUserModel(
      events: (json['events'] as List<dynamic>)
          .map((e) => EventByUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsByUserModelToJson(EventsByUserModel instance) =>
    <String, dynamic>{
      'events': instance.events,
    };
