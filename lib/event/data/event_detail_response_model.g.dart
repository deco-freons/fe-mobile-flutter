// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailResponseModel _$EventDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    EventDetailResponseModel(
      event: EventDetailModel.fromJson(json['event'] as Map<String, dynamic>),
      isEventCreator: json['isEventCreator'] as bool,
    );

Map<String, dynamic> _$EventDetailResponseModelToJson(
        EventDetailResponseModel instance) =>
    <String, dynamic>{
      'isEventCreator': instance.isEventCreator,
      'event': instance.event,
    };
