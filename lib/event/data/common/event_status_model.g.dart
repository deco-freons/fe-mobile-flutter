// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStatusModel _$EventStatusModelFromJson(Map<String, dynamic> json) =>
    EventStatusModel(
      statusName: $enumDecode(_$EventStatusEnumMap, json['statusName']),
    );

Map<String, dynamic> _$EventStatusModelToJson(EventStatusModel instance) =>
    <String, dynamic>{
      'statusName': _$EventStatusEnumMap[instance.statusName]!,
    };

const _$EventStatusEnumMap = {
  EventStatus.CREATED: 'Created',
  EventStatus.COMING_SOON: 'Coming Soon',
  EventStatus.ONGOING: 'Ongoing',
  EventStatus.IN_PROGRESS: 'In Progress',
  EventStatus.DONE: 'Done',
};
