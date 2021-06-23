import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimerNotification {
  late FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();
  var _initializeSettings = InitializationSettings(
    android: AndroidInitializationSettings('ic_launcher'),
    iOS: IOSInitializationSettings(),);
  var _generalNotificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      "channelDescription",
      importance: Importance.high,
    ), iOS: IOSNotificationDetails(),
  );

  void initializeSettings() {
    localNotification.initialize(_initializeSettings);
  }

  Future showNextSetNotification() async {
    await localNotification.show(
      0,
      "Next set brah",
      "Get up your lazy ass and never give up",
      _generalNotificationDetails,);
  }

  Future showEndTrainingSessionNotification() async {
    await localNotification.show(
      0,
      "Way to go!",
      "The training session is over. You're one step closer to your goal",
      _generalNotificationDetails,);
  }
}