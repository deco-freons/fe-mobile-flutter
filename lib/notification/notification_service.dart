// ignore_for_file: avoid_print

import 'package:flutter_boilerplate/common/utils/navigator_util.dart';
import 'package:flutter_boilerplate/page/event/event_detail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter/foundation.dart';

class NotificationService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    try {
      const androidSetting = AndroidInitializationSettings('gatherly_icon');
      const iosSetting = DarwinInitializationSettings();

      const initSettings =
          InitializationSettings(android: androidSetting, iOS: iosSetting);
      await _localNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: handleDidReceiveNotificationResponse,
      );
      if (!kReleaseMode) {
        print('setupPlugin: setup success');
      }
    } catch (e) {
      if (!kReleaseMode) {
        print("Error: $e");
      }
    }
  }

  void handleDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    String? payload = notificationResponse.payload;
    if (payload == null) return;

    if (int.tryParse(payload) == null) return;

    NavigatorUtil.navigatorKey.currentState!
        .pushNamed(EventDetail.routeName, arguments: int.parse(payload));
  }

  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required int milisecondFromNow,
      String? payload}) async {
    tz_data.initializeTimeZones();

    final scheduledDate =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, milisecondFromNow);

    const androidDetail = AndroidNotificationDetails(
      "main-channel",
      "Gatherly",
      channelDescription: "Show Event Nearby",
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetail = DarwinNotificationDetails();

    const notificationDetails =
        NotificationDetails(android: androidDetail, iOS: iosDetail);

    await _localNotificationsPlugin.zonedSchedule(
        id, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: payload);
  }
}
