import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_location_model.g.dart';

@JsonSerializable()
class ProfileLocationModel extends BaseModel {
  final String suburb;

  const ProfileLocationModel({
    required this.suburb,
  });

  factory ProfileLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileLocationModelToJson(this);
}
