import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the local notifications plugin and the timezone database
  static Future<void> initialize() async {
    tz_data.initializeTimeZones(); // Initialize the timezone database
    tz.setLocalLocation(tz.getLocation('Africa/Cairo')); // Set Egypt time zone

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Schedule a notification with a specific time
  static Future<void> showNotification(
      int id, String title, String body, DateTime scheduledDate) async {
    // Convert the scheduled date to the local timezone
    final localTime = tz.TZDateTime.from(scheduledDate, tz.local);

    // Check if the scheduled date is in the future
    if (localTime.isBefore(tz.TZDateTime.now(tz.local))) {
      print("The scheduled date must be in the future.");
      return; // Don't schedule the notification if the date is in the past
    }

    // Request the exact alarm permission
    final status = await Permission.notification.request();
    if (!status.isGranted) {
      print("Permission for exact alarms not granted.");
      return; // Don't schedule the notification if permission is not granted
    }

    const androidDetails = AndroidNotificationDetails(
      'match_channel_id',
      'Match Reminders',
      channelDescription: 'This channel is for match reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    // Schedule the notification with the required androidScheduleMode
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      localTime, // Use the TZDateTime in local timezone
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode:
          AndroidScheduleMode.exactAllowWhileIdle, // Add this argument
    );
  }
}
