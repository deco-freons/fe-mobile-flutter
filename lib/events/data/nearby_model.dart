import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nearby_model.g.dart';

@JsonSerializable()
class NearbyModel extends BaseModel {
  final List<String> categories;
  final double longitude;
  final double latitude;
  final double radius;

  const NearbyModel({
    required this.categories,
    required this.longitude,
    required this.latitude,
    required this.radius,
  });

  factory NearbyModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyModelToJson(this);

  @override
  List<Object> get props => [categories];
}
