import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotify {
  static late final FlutterLocalNotificationsPlugin _plugin;

  static Future<void> init([void Function(String?)? onSelected]) async {
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = IOSInitializationSettings();
    const initSettingsMacOS = MacOSInitializationSettings();
    const initSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'cerise');

    final initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
      macOS: initSettingsMacOS,
      linux: initSettingsLinux,
    );

    _plugin = FlutterLocalNotificationsPlugin();
    await _plugin.initialize(
      initializationSettings,
      onSelectNotification: onSelected,
    );
  }

  static Future<void> show({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'com.example.cerise',
      'cerise',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(0, title, body, notificationDetails, payload: payload);
  }
}
