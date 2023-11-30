import 'package:caodaion_flutter/service/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _AppsPageState extends State<AppsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            LocalNotification.showBigTextNotification(
              id: 0,
              title: "New Message Title",
              body: "This is the body",
              payload: "https://www.caodaion.com/",
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
            );
          },
          child: Text("Send"),
        ),
      ),
    );
  }
}
