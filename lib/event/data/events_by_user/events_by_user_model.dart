import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/events_by_user/event_by_user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'events_by_user_model.g.dart';

@JsonSerializable()
class EventsByUserModel extends BaseModel {
  final List<EventByUserModel> events;

  const EventsByUserModel({required this.events});

  factory EventsByUserModel.fromJson(Map<String, dynamic> json) =>
      _$EventsByUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventsByUserModelToJson(this);
}
