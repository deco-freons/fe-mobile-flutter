import 'package:flutter_boilerplate/common/data/base_model.dart';
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
  final String description;
  final EventParticipantModel eventCreator;
  final int participants;
  final List<EventParticipantModel> participantsList;
  final bool participated;

  const EventDetailModel(
      {required this.eventID,
      required this.eventName,
      required this.categories,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.longitude,
      required this.latitude,
      required this.description,
      required this.eventCreator,
      required this.participants,
      required this.participantsList,
      required this.participated});

  EventDetailModel copyWith(
      {int? eventID,
      String? eventName,
      List<PreferenceModel>? categories,
      String? date,
      String? startTime,
      String? endTime,
      double? longitude,
      double? latitude,
      String? description,
      EventParticipantModel? eventCreator,
      int? participants,
      List<EventParticipantModel>? participantList,
      bool? participated}) {
    return EventDetailModel(
        eventID: eventID ?? this.eventID,
        eventName: eventName ?? this.eventName,
        categories: categories ?? this.categories,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        description: description ?? this.description,
        eventCreator: eventCreator ?? this.eventCreator,
        participants: participants ?? this.participants,
        participantsList: participantsList,
        participated: participated ?? this.participated);
  }

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EventDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
