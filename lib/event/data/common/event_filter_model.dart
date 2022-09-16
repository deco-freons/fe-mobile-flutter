import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/days_to_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_categories_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_radius_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_filter_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventFilterModel extends BaseModel {
  final EventCategoriesModel? eventCategories;
  final EventRadiusModel? eventRadius;
  final DaysToEventModel? daysToEvent;

  const EventFilterModel({
    this.eventCategories,
    this.eventRadius,
    this.daysToEvent,
  });

  factory EventFilterModel.fromJson(Map<String, dynamic> json) =>
      _$EventFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventFilterModelToJson(this);
}
