import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel extends BaseModel {
  final double longitude;
  final double latitude;

  const CoordinateModel({required this.latitude, required this.longitude});

  factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);

  @override
  List<Object> get props => [longitude, latitude];
}
