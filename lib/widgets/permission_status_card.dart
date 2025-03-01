import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';

class PermissionStatusCard extends StatelessWidget {
  final NotificationController controller;

  const PermissionStatusCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isAuthorized = controller.permissionStatus.value == "AuthorizationStatus.authorized";
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: isAuthorized ? Colors.green.shade100 : Colors.red.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            "Notifications: ${isAuthorized ? "Enabled ✅" : "Disabled ❌"}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isAuthorized ? Colors.green.shade800 : Colors.red.shade800,
            ),
          ),
        ),
      );
    });
  }
}