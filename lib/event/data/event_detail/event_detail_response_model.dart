import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/event_detail/event_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail_response_model.g.dart';

@JsonSerializable()
class EventDetailResponseModel extends BaseModel {
  final bool isEventCreator;
  final EventDetailModel event;

  const EventDetailResponseModel(
      {required this.event, required this.isEventCreator});

  const EventDetailResponseModel.empty(
      {this.event = const EventDetailModel.empty(),
      this.isEventCreator = false});

  EventDetailResponseModel copyWith({
    bool? isEventCreator,
    EventDetailModel? event,
  }) {
    return EventDetailResponseModel(
        event: event ?? this.event,
        isEventCreator: isEventCreator ?? this.isEventCreator);
  }

  factory EventDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailResponseModelToJson(this);
}
