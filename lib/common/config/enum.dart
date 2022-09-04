// ignore_for_file: constant_identifier_names

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

enum WeekFilter { today, thisWeek, twoWeeks, fourWeeks, moreThanFourWeeks }

extension WeekExtension on WeekFilter {
  String get desc {
    switch (this) {
      case WeekFilter.today:
        return 'Today';
      case WeekFilter.thisWeek:
        return 'This Week';
      case WeekFilter.twoWeeks:
        return 'In 2 Weeks';
      case WeekFilter.fourWeeks:
        return 'In 4 Weeks';
      case WeekFilter.moreThanFourWeeks:
        return 'More Than 4 Weeks';
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
