import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_status_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventStatusRequestModel extends BaseModel {
  final List<EventStatus> status;

  const EventStatusRequestModel({required this.status});

  factory EventStatusRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EventStatusRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStatusRequestModelToJson(this);

  @override
  List<Object> get props => [status];
}
