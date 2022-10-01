import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/base/base_model.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_currency_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_price_response_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';
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
  final EventPriceResponseModel eventPrice;
  final EventParticipantModel eventCreator;
  final int participants;
  final List<EventParticipantModel> participantsList;
  final bool participated;
  final EventLocationModel location;
  final String locationName;
  final ImageModel? eventImage;
  final EventStatusModel eventStatus;

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
      required this.eventPrice,
      required this.eventCreator,
      required this.participants,
      required this.participantsList,
      required this.participated,
      required this.locationName,
      required this.location,
      required this.eventStatus,
      this.eventImage});

  const EventDetailModel.empty(
      {this.eventID = 0,
      this.eventName = "",
      this.categories = const [],
      this.date = "",
      this.startTime = "",
      this.endTime = "",
      this.longitude = 0,
      this.latitude = 0,
      this.shortDescription = "-",
      this.description = "-",
      this.eventPrice = const EventPriceResponseModel(
          priceID: 0,
          fee: 0,
          currency: EventCurrencyModel(currencyShortName: "AU\$")),
      this.eventCreator = const EventParticipantModel.empty(),
      this.participants = 0,
      this.participantsList = const [],
      this.participated = false,
      this.locationName = "",
      this.location = const EventLocationModel(suburb: "", city: ""),
      this.eventStatus = const EventStatusModel(statusName: EventStatus.COMING_SOON),
      this.eventImage});

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
    EventPriceResponseModel? eventPrice,
    EventParticipantModel? eventCreator,
    int? participants,
    List<EventParticipantModel>? participantList,
    bool? participated,
    String? locationName,
    EventLocationModel? location,
    EventStatusModel? eventStatus,
    ImageModel? eventImage,
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
      eventPrice: eventPrice ?? this.eventPrice,
      eventCreator: eventCreator ?? this.eventCreator,
      participants: participants ?? this.participants,
      participantsList: participantsList,
      participated: participated ?? this.participated,
      locationName: locationName ?? this.locationName,
      location: location ?? this.location,
      eventStatus: eventStatus ?? this.eventStatus,
      eventImage: eventImage ?? this.eventImage,
    );
  }

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      _$EventDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);

  @override
  List<Object> get props => [eventID];
}
