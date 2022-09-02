// ignore_for_file: constant_identifier_names

enum TextFieldType {
  string,
  password,
  date,
  category,
  eventTime,
  textArea,
  location,
  image,
  interest,
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

enum WeekFilter {
  thisWeek,
  nextWeek,
}

extension WeekExtension on WeekFilter {
  String get desc {
    switch (this) {
      case WeekFilter.thisWeek:
        return 'This Week';
      case WeekFilter.nextWeek:
        return 'Next Week';
    }
  }
}

enum DistanceFilter {
  belowFive,
  fiveToTen,
  aboveTen,
}

extension DistanceExtension on DistanceFilter {
  String get desc {
    switch (this) {
      case DistanceFilter.belowFive:
        return '< 5 km';
      case DistanceFilter.fiveToTen:
        return '5 <= km < 10';
      case DistanceFilter.aboveTen:
        return '>= 10 km';
    }
  }
}
