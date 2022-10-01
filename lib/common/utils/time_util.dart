import 'package:flutter/material.dart';

class TimeUtil {
  static double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  static bool greaterThanEqual(String startTime, String endTime) {
    List<String> splittedStartTime = startTime.split(":");
    List<String> splittedEndTime = endTime.split(":");

    TimeOfDay timeStart = TimeOfDay(
        hour: int.parse(splittedStartTime[0]),
        minute: int.parse(splittedStartTime[1]));
    TimeOfDay timeEnd = TimeOfDay(
        hour: int.parse(splittedEndTime[0]),
        minute: int.parse(splittedEndTime[1]));

    if (toDouble(timeStart) >= toDouble(timeEnd)) {
      return true;
    } else {
      return false;
    }
  }
}
