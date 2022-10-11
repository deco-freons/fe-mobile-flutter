// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:json_annotation/json_annotation.dart';

enum TextFieldType {
  string,
  password,
  date,
  suburbDropdown,
  eventTime,
  textArea,
  location,
  eventImage,
  profileImage,
  interest,
  checkbox,
  toggleSwitch,
  price,
}

enum ButtonType {
  primary,
  inverse,
  neutral,
  red,
}

enum TextButtonType {
  primary,
  secondary,
  tertiary,
  error,
  errorInverse,
  tertiaryDark,
}

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

enum PrefType {
  GM,
  MV,
  DC,
  CL,
  BB,
  NT,
  FB,
}

extension PrefExtension on PrefType {
  String get desc {
    switch (this) {
      case PrefType.GM:
        return '🎮 Gaming';
      case PrefType.MV:
        return '🎬 Movie';
      case PrefType.DC:
        return '💃️ Dancing';
      case PrefType.CL:
        return '🍽 Culinary';
      case PrefType.BB:
        return '🏀 Basketball';
      case PrefType.NT:
        return '🍃️ Nature';
      case PrefType.FB:
        return '⚽️ Football';
    }
  }
}

enum LoadingType {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}

enum BadgeTier {
  GOLD,
  SILVER,
  BRONZE,
}

extension BadgeTierExtension on BadgeTier {
  int get id {
    switch (this) {
      case BadgeTier.GOLD:
        return 20;
      case BadgeTier.SILVER:
        return 10;
      case BadgeTier.BRONZE:
        return 10;
      default:
        return 0;
    }
  }

  String get desc {
    switch (this) {
      case BadgeTier.GOLD:
        return "Gold";
      case BadgeTier.SILVER:
        return "Silver";
      case BadgeTier.BRONZE:
        return "Bronze";
      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case BadgeTier.GOLD:
        return Colors.amber;
      case BadgeTier.SILVER:
        return neutral.shade500;
      case BadgeTier.BRONZE:
        return const Color.fromARGB(255, 189, 52, 2);
      default:
        return neutral.shade100;
    }
  }
}

enum TimeFilter {
  oneDay,
  oneWeek,
  twoWeeks,
  fourWeeks,
}

extension TimeFilterExtension on TimeFilter {
  String get desc {
    switch (this) {
      case TimeFilter.oneDay:
        return '1 day';
      case TimeFilter.oneWeek:
        return '1 Week';
      case TimeFilter.twoWeeks:
        return '2 Weeks';
      case TimeFilter.fourWeeks:
        return '1 Month';
    }
  }

  int get value {
    switch (this) {
      case TimeFilter.oneDay:
        return 1;
      case TimeFilter.oneWeek:
        return 7;
      case TimeFilter.twoWeeks:
        return 14;
      case TimeFilter.fourWeeks:
        return 28;
    }
  }

  String get isMoreOrLess {
    switch (this) {
      case TimeFilter.oneDay:
        return 'LESS';
      case TimeFilter.oneWeek:
        return 'LESS';
      case TimeFilter.twoWeeks:
        return 'LESS';
      case TimeFilter.fourWeeks:
        return 'LESS';
    }
  }
}

enum DistanceFilter {
  five,
  ten,
  twenty,
  aboveTwenty,
}

extension DistanceFilterExtension on DistanceFilter {
  String get desc {
    switch (this) {
      case DistanceFilter.five:
        return '5 km';
      case DistanceFilter.ten:
        return '10 km';
      case DistanceFilter.twenty:
        return '20 km';
      case DistanceFilter.aboveTwenty:
        return '> 20 km';
    }
  }

  int get value {
    switch (this) {
      case DistanceFilter.five:
        return 5;
      case DistanceFilter.ten:
        return 10;
      case DistanceFilter.twenty:
        return 20;
      case DistanceFilter.aboveTwenty:
        return 20;
    }
  }

  String get isMoreOrLess {
    switch (this) {
      case DistanceFilter.five:
        return 'LESS';
      case DistanceFilter.ten:
        return 'LESS';
      case DistanceFilter.twenty:
        return 'LESS';
      case DistanceFilter.aboveTwenty:
        return 'MORE';
    }
  }

  List<String> get descList {
    List<String> list = [];
    for (var radius in DistanceFilter.values) {
      list.add(radius.desc);
    }
    return list;
  }
}

enum SizeFilter {
  lessThanTen,
  tenToTwenty,
  moreThanTwenty,
}

extension SizeFilterExtension on SizeFilter {
  String get desc {
    switch (this) {
      case SizeFilter.lessThanTen:
        return '<= 10 participants';
      case SizeFilter.tenToTwenty:
        return '10 < participants <= 20 ';
      case SizeFilter.moreThanTwenty:
        return '> 20 participants';
    }
  }

  int get value {
    switch (this) {
      case SizeFilter.lessThanTen:
        return 10;
      case SizeFilter.tenToTwenty:
        return 20;
      case SizeFilter.moreThanTwenty:
        return 20;
    }
  }

  String get isMoreOrLess {
    switch (this) {
      case SizeFilter.lessThanTen:
        return 'LESS';
      case SizeFilter.tenToTwenty:
        return 'LESS';
      case SizeFilter.moreThanTwenty:
        return 'MORE';
    }
  }
}

enum EventSort {
  daysNearToFar,
  daysFarToNear,
  mostPopular,
  distanceNearToFar,
  distanceFarToNear,
  priceLowToHigh,
  priceHighToLow
}

extension EventSortExtension on EventSort {
  String get desc {
    switch (this) {
      case EventSort.daysNearToFar:
        return 'Days to Event: Nearest to Farthest';
      case EventSort.daysFarToNear:
        return 'Days to Event: Farthest to Nearest';
      case EventSort.mostPopular:
        return 'Most Popular';
      case EventSort.distanceNearToFar:
        return 'Distance: Nearest to Farthest';
      case EventSort.distanceFarToNear:
        return 'Distance: Farthest to Nearest';
      case EventSort.priceLowToHigh:
        return 'Price: Lowest to Highest';
      case EventSort.priceHighToLow:
        return 'Price: Highest to Lowest';
    }
  }

  String get value {
    switch (this) {
      case EventSort.daysNearToFar:
        return 'DAYS_TO_EVENT';
      case EventSort.daysFarToNear:
        return 'DAYS_TO_EVENT';
      case EventSort.mostPopular:
        return 'POPULARITY';
      case EventSort.distanceNearToFar:
        return 'DISTANCE';
      case EventSort.distanceFarToNear:
        return 'DISTANCE';
      case EventSort.priceLowToHigh:
        return 'PRICE';
      case EventSort.priceHighToLow:
        return 'PRICE';
    }
  }

  String get order {
    switch (this) {
      case EventSort.daysNearToFar:
        return 'LESS';
      case EventSort.daysFarToNear:
        return 'MORE';
      case EventSort.mostPopular:
        return 'MORE';
      case EventSort.distanceNearToFar:
        return 'LESS';
      case EventSort.distanceFarToNear:
        return 'MORE';
      case EventSort.priceLowToHigh:
        return 'LESS';
      case EventSort.priceHighToLow:
        return 'MORE';
    }
  }
}

enum CardStatus {
  join,
  skip,
}

enum ImageInputAction {
  DO_NOTHING,
  UPLOAD,
  REMOVE,
}

enum EventJoinedCardType {
  SCHEDULED,
  HISTORY,
  REMINDER,
}

enum EventStatus {
  @JsonValue("Created")
  CREATED,
  @JsonValue("Coming Soon")
  COMING_SOON,
  @JsonValue("Ongoing")
  ONGOING,
  @JsonValue("In Progress")
  IN_PROGRESS,
  @JsonValue("Done")
  DONE,
}
