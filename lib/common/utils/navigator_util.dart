import 'package:flutter/material.dart';

class NavigatorUtil {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static void goBacknTimes(BuildContext context, int count) {
    int counter = 0;
    Navigator.of(context).popUntil((_) => counter++ >= count);
  }
}
