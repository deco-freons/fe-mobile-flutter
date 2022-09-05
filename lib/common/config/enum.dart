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

enum DaysFilter { oneDay, oneWeek, twoWeeks, fourWeeks }

extension DaysDescExtension on DaysFilter {
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
}

extension DaysValueExtension on DaysFilter {
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
}

extension DaysMoreLessExtension on DaysFilter {
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

extension DistanceDescExtension on DistanceFilter {
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
}

extension DistanceValueExtension on DistanceFilter {
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
}

extension DistanceMoreLessExtension on DistanceFilter {
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
}
