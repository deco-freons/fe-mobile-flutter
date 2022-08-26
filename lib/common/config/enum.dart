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
}

enum ButtonType { primary, inverse, red }

enum TextButtonType {
  primary,
  secondary,
  tertiary,
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

  String get id {
    switch (this) {
      case PrefType.GM:
        return 'GM';
      case PrefType.MV:
        return 'MV';
      case PrefType.DC:
        return 'DC';
      case PrefType.CL:
        return 'CL';
      case PrefType.BB:
        return 'BB';
      case PrefType.NT:
        return 'NT';
      case PrefType.FB:
        return 'FB';
    }
  }
}
