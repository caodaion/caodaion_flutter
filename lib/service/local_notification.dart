import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class LocalNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/launcher_icon');

    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    var initilizationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initilizationSettings);
  }

  static Future showBigTextNotification({
    required int id,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    var androidNotificationDetails = const AndroidNotificationDetails(
      "caodaion_notification",
      "chanel_name",
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
        "notification",
      ),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentSound: false);

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
