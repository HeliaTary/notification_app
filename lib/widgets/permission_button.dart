import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';

class RequestPermissionButton extends StatelessWidget {
  final NotificationController controller;

  const RequestPermissionButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.permissionStatus.value == "AuthorizationStatus.denied"
          ? ElevatedButton.icon(
            onPressed: controller.requestPermission,
            icon: const Icon(Icons.notifications),
            label: const Text("Enable Notifications"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
          : const SizedBox();
    });
  }
}
