import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/common/data/image_model.dart';
import 'package:flutter_boilerplate/event/components/event_matching/event_matching_home_card.dart';
import 'package:flutter_boilerplate/event/data/common/event_currency_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_location_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_participant_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_price_response_model.dart';
import 'package:flutter_boilerplate/event/data/common/event_status_model.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_response_model.dart';

EventMatchingCardHome exampleFeaturedEventCard = EventMatchingCardHome(
  title: "Harry Styles with Jennie",
  author: "Jennie Kim",
  distance: 2,
  location: 'Marvel Stadium, Melbourne',
  month: "Mar",
  date: "24",
  image: "lib/common/assets/images/LargeEventImage.png",
  isAssetImage: true,
  fee: 0,
  onTapHandler: () {},
);

List<EventModel> exampleEvents = [
  const EventModel(
    eventID: 1,
    eventName: "Live Music at City Hall",
    date: "2000-12-12",
    distance: 2,
    longitude: 13,
    latitude: 13,
    eventCreator: EventParticipantModel(
        username: "creator1", firstName: "Dwayne", lastName: "Johnson"),
    location: EventLocationModel(suburb: "Brisbane City", city: "Brisbane"),
    locationName: "City Hall",
    participants: 12,
    eventStatus: EventStatusModel(statusName: EventStatus.COMING_SOON),
    eventImage: ImageModel(
        imageUrl: "lib/common/assets/images/SmallEventImageBand.png"),
    eventPrice: EventPriceResponseModel(
      priceID: 0,
      fee: 20,
      currency: EventCurrencyModel(currencyShortName: "AU\$"),
    ),
  ),
  const EventModel(
    eventID: 2,
    eventName: "Dessert Crawl at West End",
    date: "2023-06-04",
    distance: 3,
    longitude: 12,
    latitude: 12,
    eventCreator: EventParticipantModel(
        username: "creator1", firstName: "Zahra", lastName: "Abraara"),
    location: EventLocationModel(suburb: "West End", city: "Brisbane"),
    locationName: "Kings George Station",
    participants: 10,
    eventStatus: EventStatusModel(statusName: EventStatus.COMING_SOON),
    eventImage: ImageModel(
        imageUrl: "lib/common/assets/images/SmallEventImageCake.png"),
    eventPrice: EventPriceResponseModel(
      priceID: 0,
      fee: 20,
      currency: EventCurrencyModel(currencyShortName: "AU\$"),
    ),
  ),
];

final List<EventMatchingResponseModel> exampleEventMatching = [
  const EventMatchingResponseModel(
    eventID: 1,
    eventName: "Harry Styles with Jennie",
    date: "2023-03-24",
    distance: 2,
    longitude: 12,
    latitude: 12,
    eventCreator: EventParticipantModel(
        username: "JennieKim", firstName: "Jennie", lastName: "Kim"),
    location: EventLocationModel(suburb: "Docklands", city: "Melbourne"),
    locationName: "Marvel Stadium",
    participants: 10,
    startTime: "11:11",
    endTime: "12:12",
    eventStatus: EventStatusModel(statusName: EventStatus.COMING_SOON),
    eventImage:
        ImageModel(imageUrl: "lib/common/assets/images/LargeEventImage.png"),
    shortDescription:
        "Harry Styles Love On Tour Melbourne concert for you Harry Style's fan.",
    eventPrice: EventPriceResponseModel(
      priceID: 0,
      fee: 20,
      currency: EventCurrencyModel(currencyShortName: "AU\$"),
    ),
  ),
];
