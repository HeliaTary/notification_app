import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';
import 'package:notification/widgets/notification_card.dart'; // Import the new widget

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.notifications_active,
                  size: 80,
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: NotificationCard(
                    title: controller.notificationTitle.value,
                    body: controller.notificationBody.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
