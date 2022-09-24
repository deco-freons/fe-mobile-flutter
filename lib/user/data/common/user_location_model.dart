import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_location_model.g.dart';

@JsonSerializable()
class UserLocationModel extends BaseModel {
  final String suburb;

  const UserLocationModel({required this.suburb});

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationModelToJson(this);

  @override
  List<Object> get props => [suburb];
}
