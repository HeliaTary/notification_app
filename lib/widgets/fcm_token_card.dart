import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/controller/notification_controller.dart';


class FcmTokenCard extends StatelessWidget {
  final NotificationController controller;

  const FcmTokenCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final token = controller.fcmToken.value;
      return token.isNotEmpty
          ? Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "FCM Token:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SelectableText(
                token,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )
          : const SizedBox();
    });
  }
}