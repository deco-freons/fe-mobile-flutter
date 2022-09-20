import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_location_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'event_matching_response_model.g.dart';

@JsonSerializable()
class EventMatchingResponseModel extends BaseModel {
  final int eventID;
  final String eventName;
  final String date;
  final String startTime;
  final String endTime;
  final double distance;
  final double longitude;
  final double latitude;
  final String shortDescription;
  final EventParticipantModel eventCreator;
  final PopularEventLocationModel location;
  final String locationName;
  final int participants;

  const EventMatchingResponseModel(
      {required this.eventID,
      required this.eventName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.distance,
      required this.longitude,
      required this.latitude,
      required this.shortDescription,
      required this.eventCreator,
      required this.location,
      required this.locationName,
      required this.participants});

  factory EventMatchingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventMatchingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventMatchingResponseModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
