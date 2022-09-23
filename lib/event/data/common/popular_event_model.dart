import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_location_model.dart';

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
  final EventParticipantModel eventCreator;
  final PopularEventLocationModel location;
  final String locationName;
  final int participants;
  final ImageModel? eventImage;

  const PopularEventModel(
      {required this.eventID,
      required this.eventName,
      required this.date,
      required this.distance,
      required this.longitude,
      required this.latitude,
      required this.eventCreator,
      required this.location,
      required this.locationName,
      required this.participants,
      this.eventImage});

  factory PopularEventModel.fromJson(Map<String, dynamic> json) =>
      _$PopularEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularEventModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
