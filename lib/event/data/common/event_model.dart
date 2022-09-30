import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';

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
  final EventParticipantModel eventCreator;
  final EventLocationModel location;
  final String locationName;
  final int participants;
  final EventStatusModel eventStatus;

  final ImageModel? eventImage;

  const EventModel(
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
      required this.eventStatus,
      this.eventImage});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
