// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_status_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventStatusRequestModel _$EventStatusRequestModelFromJson(
        Map<String, dynamic> json) =>
    EventStatusRequestModel(
      status: (json['status'] as List<dynamic>)
          .map((e) => $enumDecode(_$EventStatusEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$EventStatusRequestModelToJson(
        EventStatusRequestModel instance) =>
    <String, dynamic>{
      'status': instance.status.map((e) => _$EventStatusEnumMap[e]!).toList(),
    };

const _$EventStatusEnumMap = {
  EventStatus.CREATED: 'Created',
  EventStatus.COMING_SOON: 'Coming Soon',
  EventStatus.ONGOING: 'Ongoing',
  EventStatus.IN_PROGRESS: 'In Progress',
  EventStatus.DONE: 'Done',
};
