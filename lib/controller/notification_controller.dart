import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification/pages/page_b.dart';
import 'package:notification/services/fcm_service.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final RxString notificationTitle = ''.obs;
  final RxString notificationBody = ''.obs;
  final RxString permissionStatus = "Unknown".obs;
  final RxString fcmToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkPermission();
    _listenToNotifications();
    _fetchFCMToken();
    checkInitialMessage();
  }

  Future<void> _fetchFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    fcmToken.value = token ?? "Token not available";
  }

  Future<void> _checkPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
    permissionStatus.value = settings.authorizationStatus.toString();
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    permissionStatus.value = settings.authorizationStatus.toString();
  }

  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((message) {
      NotificationService.instance.displayNotification(message);
      navigateToDetails(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigateToDetails(message);
    });
  }

  Future<void> checkInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await Future.delayed(Duration.zero);
      navigateToDetails(initialMessage);
    }
  }

  void navigateToDetails(RemoteMessage message) {
    notificationTitle.value = message.notification?.title ?? "No Title";
    notificationBody.value = message.notification?.body ?? "No Body";

    if (Get.currentRoute == "/details") {
      update();
    } else {
      Get.to(() => ScreenB());
    }
  }
}
