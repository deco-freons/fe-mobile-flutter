import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_event_model.g.dart';

@JsonSerializable()
class EditEventModel extends BaseModel {
  final int eventID;
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

  const EditEventModel(
      {required this.eventID,
      required this.eventName,
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

  factory EditEventModel.fromJson(Map<String, dynamic> json) =>
      _$EditEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditEventModelToJson(this);
}
