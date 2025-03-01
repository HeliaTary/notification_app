import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';
import 'package:notification/routes/routes.dart';
import 'package:notification/services/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();

  Get.put(NotificationController()); // Register controller

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notification App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      getPages: appRoutes,
    );
  }
}

// class NotificationHandler {
//   static void initializeFCM() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Foreground Notification: ${message.notification?.title}");
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("Notification Clicked: ${message.notification?.title}");
//       if (Get.currentRoute != "/details") {
//         Get.toNamed("/details"); // Ensure navigation to ScreenB
//       }
//     });
//   }
// }