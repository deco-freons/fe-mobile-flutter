import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'event_matching_response_model.g.dart';

@JsonSerializable()
class EventMatchingResponseModel extends EventModel {
  final String startTime;
  final String endTime;

  final String shortDescription;

  const EventMatchingResponseModel({
    required int eventID,
    required String eventName,
    required String date,
    required this.startTime,
    required this.endTime,
    required double distance,
    required double longitude,
    required double latitude,
    required this.shortDescription,
    required EventParticipantModel eventCreator,
    required EventLocationModel location,
    required String locationName,
    required int participants,
    required EventStatusModel eventStatus,
    ImageModel? eventImage,
  }) : super(
          eventID: eventID,
          eventName: eventName,
          date: date,
          distance: distance,
          longitude: longitude,
          latitude: latitude,
          eventCreator: eventCreator,
          location: location,
          locationName: locationName,
          participants: participants,
          eventImage: eventImage,
          eventStatus: eventStatus,
        );

  factory EventMatchingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventMatchingResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventMatchingResponseModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
