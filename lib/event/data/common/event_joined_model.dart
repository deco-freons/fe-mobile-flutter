import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_joined_model.g.dart';

@JsonSerializable()
class EventJoinedModel extends EventModel {
  final List<EventParticipantModel> participantsList;
  final bool isEventCreator;

  const EventJoinedModel(
      {required int eventID,
      required String eventName,
      required String date,
      required double distance,
      required double longitude,
      required double latitude,
      required EventParticipantModel eventCreator,
      required EventLocationModel location,
      required String locationName,
      required int participants,
      required EventStatusModel eventStatus,
      ImageModel? eventImage,
      required this.participantsList,
      required this.isEventCreator})
      : super(
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

  factory EventJoinedModel.fromJson(Map<String, dynamic> json) =>
      _$EventJoinedModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventJoinedModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
