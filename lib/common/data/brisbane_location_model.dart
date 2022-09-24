// ignore_for_file: non_constant_identifier_names

import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brisbane_location_model.g.dart';

@JsonSerializable()
class BrisbaneLocationModel extends BaseModel {
  final int location_id;
  final String suburb;
  final String city;
  final String state;
  final String country;

  const BrisbaneLocationModel({
    required this.location_id,
    required this.suburb,
    required this.city,
    required this.state,
    required this.country,
  });

  factory BrisbaneLocationModel.fromJson(Map<String, dynamic> json) =>
      _$BrisbaneLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrisbaneLocationModelToJson(this);

  bool locationFilterBySuburb(String filter) {
    return suburb.toLowerCase().contains(filter.toLowerCase());
  }
}
