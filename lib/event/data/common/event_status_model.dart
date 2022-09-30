import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_status_model.g.dart';

@JsonSerializable()
class EventStatusModel extends BaseModel {
  final EventStatus statusName;

  const EventStatusModel({required this.statusName});

  factory EventStatusModel.fromJson(Map<String, dynamic> json) =>
      _$EventStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventStatusModelToJson(this);

  @override
  List<Object> get props => [statusName];
}
