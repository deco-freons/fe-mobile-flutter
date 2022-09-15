import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_radius_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EventRadiusModel extends BaseModel {
  final int radius;
  final String isMoreOrLess;

  const EventRadiusModel({
    required this.radius,
    required this.isMoreOrLess,
  });

  factory EventRadiusModel.fromJson(Map<String, dynamic> json) =>
      _$EventRadiusModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventRadiusModelToJson(this);

  @override
  List<Object> get props => [radius];
}
