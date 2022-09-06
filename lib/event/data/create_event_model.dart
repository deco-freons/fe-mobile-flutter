import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_event_model.g.dart';

@JsonSerializable()
class CreateEventModel extends BaseModel {
  final String eventName;
  final List<String> categories;
  final String date;
  final String startTime;
  final String endTime;
  final String longitude;
  final String latitude;
  final int location;
  final String locationName;
  final String shortDescription;
  final String description;

  const CreateEventModel(
      {required this.eventName,
      required this.categories,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.longitude,
      required this.latitude,
      required this.location,
      required this.locationName,
      required this.shortDescription,
      required this.description});

  factory CreateEventModel.fromJson(Map<String, dynamic> json) =>
      _$CreateEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEventModelToJson(this);
}
