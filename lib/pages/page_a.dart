import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';
import 'package:notification/widgets/fcm_token_card.dart';
import 'package:notification/widgets/permission_button.dart';
import 'package:notification/widgets/permission_status_card.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the Notification App!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            const Icon(Icons.notifications_active, size: 80, color: Colors.blue),
            const SizedBox(height: 20),

            PermissionStatusCard(controller: controller),
            const SizedBox(height: 20),

            RequestPermissionButton(controller: controller),
            const SizedBox(height: 20),

            // FcmTokenCard(controller: controller),
          ],
        ),
      ),
    );
  }
}

