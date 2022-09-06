import 'package:flutter_boilerplate/common/data/base_model.dart';
import 'package:flutter_boilerplate/event/data/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';
import 'package:flutter_boilerplate/preference/data/preference_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_detail_model.g.dart';

@JsonSerializable()
class EventDetailModel extends BaseModel {
  final int eventID;
  final String eventName;
  final List<PreferenceModel> categories;
  final String date;
  final String startTime;
  final String endTime;
  final double longitude;
  final double latitude;
  final String shortDescription;
  final String description;
  final EventParticipantModel eventCreator;
  final int participants;
  final List<EventParticipantModel> participantsList;
  final bool participated;
  final EventLocationModel location;
  final String locationName;

  const EventDetailModel(
      {required this.eventID,
      required this.eventName,
      required this.categories,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.longitude,
      required this.latitude,
      required this.shortDescription,
      required this.description,
      required this.eventCreator,
      required this.participants,
      required this.participantsList,
      required this.participated,
      required this.locationName,
      required this.location});

  const EventDetailModel.empty({
    this.eventID = 0,
    this.eventName = "",
    this.categories = const [],
    this.date = "",
    this.startTime = "",
    this.endTime = "",
    this.longitude = 0,
    this.latitude = 0,
    this.shortDescription = "-",
    this.description = "-",
    this.eventCreator = const EventParticipantModel.empty(),
    this.participants = 0,
    this.participantsList = const [],
    this.participated = false,
    this.locationName = "",
    this.location = const EventLocationModel(suburb: "", city: ""),
  });

  EventDetailModel copyWith({
    int? eventID,
    String? eventName,
    List<PreferenceModel>? categories,
    String? date,
    String? startTime,
    String? endTime,
    double? longitude,
    double? latitude,
    String? shortDescription,
    String? description,
    EventParticipantModel? eventCreator,
    int? participants,
    List<EventParticipantModel>? participantList,
    bool? participated,
    String? locationName,
    EventLocationModel? location,
  }) {
    return EventDetailModel(
        eventID: eventID ?? this.eventID,
        eventName: eventName ?? this.eventName,
        categories: categories ?? this.categories,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        eventCreator: eventCreator ?? this.eventCreator,
        participants: participants ?? this.participants,
        participantsList: participantsList,
        participated: participated ?? this.participated,
        locationName: locationName ?? this.locationName,
        location: location ?? this.location);
  }

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EventDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
