// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';

enum TextFieldType {
  string,
  password,
  date,
  suburbDropdown,
  eventTime,
  textArea,
  location,
  image,
  interest,
  checkbox,
  toggleSwitch,
}

enum ButtonType { primary, inverse, red }

enum TextButtonType {
  primary,
  secondary,
  tertiary,
  error,
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

enum BadgeTier { GOLD, SILVER, BRONZE }

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

enum DaysFilter {
  oneDay,
  oneWeek,
  twoWeeks,
  fourWeeks,
}

extension DaysFilterExtension on DaysFilter {
  String get desc {
    switch (this) {
      case DaysFilter.oneDay:
        return '1 day';
      case DaysFilter.oneWeek:
        return '1 Week';
      case DaysFilter.twoWeeks:
        return '2 Weeks';
      case DaysFilter.fourWeeks:
        return '1 Month';
    }
  }

  int get value {
    switch (this) {
      case DaysFilter.oneDay:
        return 1;
      case DaysFilter.oneWeek:
        return 7;
      case DaysFilter.twoWeeks:
        return 14;
      case DaysFilter.fourWeeks:
        return 28;
    }
  }

  String get isMoreOrLess {
    switch (this) {
      case DaysFilter.oneDay:
        return 'LESS';
      case DaysFilter.oneWeek:
        return 'LESS';
      case DaysFilter.twoWeeks:
        return 'LESS';
      case DaysFilter.fourWeeks:
        return 'LESS';
    }
  }
}

enum DistanceFilter { five, ten, twenty, aboveTwenty }

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
