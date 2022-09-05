import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_event_model.g.dart';

@JsonSerializable()
class FilterEventModel extends BaseModel {
  final Map<String, dynamic>? eventCategories;
  final Map<String, dynamic>? eventRadius;
  final Map<String, dynamic>? daysToEvent;

  const FilterEventModel({
    required this.eventCategories,
    required this.eventRadius,
    required this.daysToEvent,
  });

  factory FilterEventModel.fromJson(Map<String, dynamic> json) =>
      _$FilterEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterEventModelToJson(this);
}
