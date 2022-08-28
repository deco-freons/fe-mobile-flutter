import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_event_model.g.dart';

@JsonSerializable()
class PopularEventModel extends BaseModel {
  final int eventID;
  final String eventName;
  final String date;
  final double distance;
  final double longitude;
  final double latitude;
  final Map<String, String> eventCreator;
  final List<String> location;

  const PopularEventModel({
    required this.eventID,
    required this.eventName,
    required this.date,
    required this.distance,
    required this.longitude,
    required this.latitude,
    required this.eventCreator,
    required this.location,
  });

  factory PopularEventModel.fromJson(Map<String, dynamic> json) =>
      _$PopularEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularEventModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
