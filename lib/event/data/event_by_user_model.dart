import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_by_user_model.g.dart';

@JsonSerializable()
class EventByUserModel extends BaseModel {
  final int eventID;
  final String eventName;
  final double distance;
  final String date;
  final double longitude;
  final double latitude;
  final EventImageModel? eventImage;

  const EventByUserModel(
      {required this.eventID,
      required this.eventName,
      required this.distance,
      required this.date,
      required this.latitude,
      required this.longitude,
      required this.eventImage});

  factory EventByUserModel.fromJson(Map<String, dynamic> json) =>
      _$EventByUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventByUserModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
