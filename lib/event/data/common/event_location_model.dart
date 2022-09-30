import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_location_model.g.dart';

@JsonSerializable()
class EventLocationModel extends BaseModel {
  final String suburb;
  final String city;

  const EventLocationModel({
    required this.suburb,
    required this.city,
  });

  factory EventLocationModel.fromJson(Map<String, dynamic> json) =>
      _$EventLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventLocationModelToJson(this);
}
