import 'package:flutter/material.dart';

// theme data options: https://api.flutter.dev/flutter/material/ThemeData-class.html
class CustomTheme {
  static ThemeData get theme => ThemeData(
        primarySwatch: primary,
        fontFamily: 'NunitoSans',
        backgroundColor: neutral,
        primaryColor: primary,
        colorScheme: colorScheme,
      );
}

const ColorScheme colorScheme = ColorScheme(
    primary: primary,
    secondary: neutral,
    tertiary: grey,
    surface: neutral,
    onPrimary: neutral,
    background: neutral,
    onSurface: primary,
    onBackground: neutral,
    onSecondary: primary,
    error: error,
    brightness: Brightness.light,
    onError: neutral,
    onSurfaceVariant: black);

const MaterialColor primary = MaterialColor(0xFF0AA1DD, <int, Color>{
  50: Color(0xFF0AA1DD),
  100: Color(0xFF0AA1DD),
  200: Color(0xFF0AA1DD),
  300: Color(0xFF0AA1DD),
  400: Color(0xFF0AA1DD),
  500: Color(0xFF0AA1DD),
  600: Color(0xFF0AA1DD),
  700: Color(0xFF0AA1DD),
  800: Color(0xFF0AA1DD),
  900: Color(0xFF0AA1DD),
});

const MaterialColor neutral = MaterialColor(0xFFFFFFFF, <int, Color>{
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(0xFFFFFFFF),
  600: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
  800: Color(0xFFFFFFFF),
  900: Color(0xFFFFFFFF),
});

const MaterialColor grey = MaterialColor(0xFF8E9093, <int, Color>{
  50: Color(0xFF8E9093),
  100: Color(0xFF8E9093),
  200: Color(0xFF8E9093),
  300: Color(0xFF8E9093),
  400: Color(0xFF8E9093),
  500: Color(0xFF8E9093),
  600: Color(0xFF8E9093),
  700: Color(0xFF8E9093),
  800: Color(0xFF8E9093),
  900: Color(0xFF8E9093),
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

const MaterialColor black = MaterialColor(0xFF1E1E1E, <int, Color>{
  50: Color(0xFF1E1E1E),
  100: Color(0xFF1E1E1E),
  200: Color(0xFF1E1E1E),
  300: Color(0xFF404852),
  400: Color(0xFF1E1E1E),
  500: Color(0xFF1E1E1E),
  600: Color(0xFF1E1E1E),
  700: Color(0xFF1E1E1E),
  800: Color(0xFF1E1E1E),
  900: Color(0xFF1E1E1E),
});
