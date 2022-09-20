import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_image_model.g.dart';

@JsonSerializable()
class EventImageModel extends BaseModel {
  final String imageUrl;

  const EventImageModel({required this.imageUrl});

  factory EventImageModel.fromJson(Map<String, dynamic> json) =>
      _$EventImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventImageModelToJson(this);
}
