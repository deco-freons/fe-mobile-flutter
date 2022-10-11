import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_filter_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_reminder_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventReminderRequestModel extends BaseModel {
  final double longitude;
  final double latitude;
  final String todaysDate;
  final EventFilterModel filter;

  const EventReminderRequestModel(
      {required this.longitude,
      required this.latitude,
      required this.todaysDate,
      required this.filter});

  factory EventReminderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EventReminderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventReminderRequestModelToJson(this);
}
