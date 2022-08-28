import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends BaseModel {
  final int eventID;
  final String eventName;
  final String date;
  final double distance;
  final double longitude;
  final double latitude;
  final Map<String, String> eventCreator;

  const EventModel({
    required this.eventID,
    required this.eventName,
    required this.date,
    required this.distance,
    required this.longitude,
    required this.latitude,
    required this.eventCreator,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
