import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_filter_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_status_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_joined_request_model.g.dart';

@JsonSerializable()
class EventJoinedRequestModel extends BaseModel {
  final double longitude;
  final double latitude;
  final EventFilterModel filter;

  const EventJoinedRequestModel(
      {required this.longitude, required this.latitude, required this.filter});

  const EventJoinedRequestModel.history({
    required this.latitude,
    required this.longitude,
    this.filter = const EventFilterModel(
      eventStatus: EventStatusRequestModel(status: [EventStatus.DONE]),
    ),
  });

  const EventJoinedRequestModel.scheduled({
    required this.latitude,
    required this.longitude,
    this.filter = const EventFilterModel(
      eventStatus: EventStatusRequestModel(status: [EventStatus.COMING_SOON]),
    ),
  });

  factory EventJoinedRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EventJoinedRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventJoinedRequestModelToJson(this);
}
