import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'empty_nearby_model.g.dart';

@JsonSerializable()
class EmptyNearbyModel extends BaseModel {
  final double longitude;
  final double latitude;
  final double radius;

  const EmptyNearbyModel({
    required this.longitude,
    required this.latitude,
    required this.radius,
  });

  factory EmptyNearbyModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyNearbyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyNearbyModelToJson(this);

  @override
  List<Object> get props => [longitude];
}
