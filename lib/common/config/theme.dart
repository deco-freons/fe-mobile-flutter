import 'package:flutter/material.dart';

// theme data options: https://api.flutter.dev/flutter/material/ThemeData-class.html
class CustomTheme {
  static ThemeData get theme => ThemeData(
        primarySwatch: primary,
        fontFamily: 'NunitoSans',
        backgroundColor: neutral.shade100,
        primaryColor: primary,
        colorScheme: colorScheme,
      );
}

ColorScheme colorScheme = ColorScheme(
  primary: primary,
  secondary: neutral.shade100,
  tertiary: neutral.shade400,
  surface: neutral.shade800,
  onPrimary: neutral.shade100,
  background: neutral.shade100,
  onSurface: primary,
  onBackground: neutral.shade100,
  onSecondary: primary,
  error: error,
  brightness: Brightness.light,
  onError: neutral.shade100,
  onSurfaceVariant: neutral.shade800,
);

const MaterialColor primary = MaterialColor(0xFF0AA1DD, <int, Color>{
  50: Color(0xFF0AA1DD),
  100: Color(0xFF0AA1DD),
  200: Color(0xFF0AA1DD),
  300: Color(0xFFE1F5FD),
  400: Color(0xFFB2DBEB),
  500: Color(0xFF0AA1DD),
  600: Color(0xFF184B5F),
  700: Color(0xFF0AA1DD),
  800: Color(0xFF0AA1DD),
  900: Color(0xFF0AA1DD),
});

const MaterialColor neutral = MaterialColor(0xFF8E9093, <int, Color>{
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFF8E9093),
  300: Color(0xFF8E9093),
  400: Color(0xFFD9D9D9),
  500: Color(0xFF8E9093),
  600: Color(0xFF8E9093),
  700: Color(0xFF404852),
  800: Color(0xFF1E1E1E),
  900: Color(0xFF000000),
});

const MaterialColor error = MaterialColor(0xFFFC1313, <int, Color>{
  50: Color(0xFFFC1313),
  100: Color(0xFFFC1313),
  200: Color(0xFFFC1313),
  300: Color(0xFFFC1313),
  400: Color(0xFFFC1313),
  500: Color(0xFFFC1313),
  600: Color(0xFFFC1313),
  700: Color(0xFFFC1313),
  800: Color(0xFFFC1313),
  900: Color(0xFFFC1313),
});
