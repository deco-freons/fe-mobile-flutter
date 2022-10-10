import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/days_to_event_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_categories_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_price_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_radius_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/event_status_request_model.dart';
import 'package:flutter_boilerplate/event/data/common/filter/participant_size_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_filter_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class EventFilterModel extends BaseModel {
  final EventCategoriesModel? eventCategories;
  final EventRadiusModel? eventRadius;
  final DaysToEventModel? daysToEvent;
  final EventStatusRequestModel? eventStatus;
  final ParticipantSizeModel? eventParticipants;
  final EventPriceModel? eventPrice;

  const EventFilterModel({
    this.eventCategories,
    this.eventRadius,
    this.daysToEvent,
    this.eventParticipants,
    this.eventPrice,
    this.eventStatus,
  });

  factory EventFilterModel.fromJson(Map<String, dynamic> json) =>
      _$EventFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventFilterModelToJson(this);
}
