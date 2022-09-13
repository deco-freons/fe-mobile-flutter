import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_event_location_model.g.dart';

@JsonSerializable()
class PopularEventLocationModel extends BaseModel {
  final String suburb;
  final String city;
  final String state;

  const PopularEventLocationModel({
    required this.suburb,
    required this.city,
    required this.state,
  });

  factory PopularEventLocationModel.fromJson(Map<String, dynamic> json) =>
      _$PopularEventLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularEventLocationModelToJson(this);
}