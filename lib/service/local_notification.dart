import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    print(id);
    print(title);
    print(body);
    print(payload);

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("caodaion_notification", "chanel_name",
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(presentSound: false);

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}
