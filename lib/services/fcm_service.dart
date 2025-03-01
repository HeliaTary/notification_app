import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupLocalNotifications();
  await NotificationService.instance.displayNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await _requestNotificationPermission();
      await setupLocalNotifications();

      final token = await _messaging.getToken();
      print('Device FCM Token: $token');
    } catch (e) {
      print("Error initializing NotificationService: $e");
    }
  }

  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.getNotificationSettings();

    if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    print('Notification Permission: ${settings.authorizationStatus}');
  }

  Future<void> setupLocalNotifications() async {
    if (_isLocalNotificationsInitialized) return;

    const AndroidNotificationChannel notificationChannel = AndroidNotificationChannel(
      'app_alerts_channel',
      'App Alerts',
      importance: Importance.max,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Notification Clicked: ${details.payload}");
      },
    );

    _isLocalNotificationsInitialized = true;
  }

  Future<void> displayNotification(RemoteMessage message) async {
    try {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        await _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'app_alerts_channel',
              'App Alerts',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: const DarwinNotificationDetails(),
          ),
        );
      }
    } catch (e) {
      print("Error displaying notification: $e");
    }
  }
}
