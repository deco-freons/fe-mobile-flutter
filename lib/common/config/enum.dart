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
