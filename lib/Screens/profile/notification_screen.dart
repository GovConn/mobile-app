import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

// Enum to represent the status of a notification
enum NotificationStatus { reminder, actionRequired, success, info }

// Data model for a notification
class AppNotification {
  final String message;
  final NotificationStatus status;

  AppNotification({required this.message, required this.status});
}

// Data model for a group of notifications by date
class NotificationGroup {
  final String date;
  final List<AppNotification> notifications;

  NotificationGroup({required this.date, required this.notifications});
}

class NotificationsScreen extends StatelessWidget {
   NotificationsScreen({super.key});

  // Sample data for the notifications
  final List<NotificationGroup> notificationGroups =  [
    NotificationGroup(
      date: '2025 - August - 25',
      notifications: [
        AppNotification(
          message: 'Reminder: Scheduled appointment at Divisional Secretariat on August 23, 2025.',
          status: NotificationStatus.reminder,
        ),
        AppNotification(
          message: 'Additional documents required: Please upload your proof of address to continue.',
          status: NotificationStatus.actionRequired,
        ),
      ],
    ),
    NotificationGroup(
      date: '2025 - August - 24',
      notifications: [
        AppNotification(
          message: 'Vehicle registration expires in 5 days. Pay renewal fee to avoid penalties.',
          status: NotificationStatus.reminder,
        ),
        AppNotification(
          message: 'Your request for a passport renewal has been successfully submitted and is under review.',
          status: NotificationStatus.success,
        ),
      ],
    ),
     NotificationGroup(
      date: '2025 - August - 23',
      notifications: [
        AppNotification(
          message: 'New e-Services are available for land registration. Explore now!',
          status: NotificationStatus.info,
        ),
      ],
    ),
  ];

  // Helper method to get the color based on the status
  Color _getColorForStatus(NotificationStatus status) {
    switch (status) {
      case NotificationStatus.reminder:
        return primaryColorLight;
      case NotificationStatus.actionRequired:
        return const Color(0xFFF87171);
      case NotificationStatus.success:
      case NotificationStatus.info:
        return const Color(0xFF4ADE80);
      default:
        return lightGreyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: blackPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('back', style: TextStyle(color: blackPrimary, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 24.0),
              child: Text(
                'Notifications',
                style: TextStyle(color: blackPrimary, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notificationGroups.length,
                itemBuilder: (context, index) {
                  final group = notificationGroups[index];
                  return _buildNotificationGroup(group);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationGroup(NotificationGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 8.0),
          child: Text(
            group.date,
            style: const TextStyle(color: greyTextColor, fontSize: 14),
          ),
        ),
        ...group.notifications.map((notification) => _buildNotificationCard(notification)).toList(),
      ],
    );
  }

  Widget _buildNotificationCard(AppNotification notification) {
    return Card(
      color: _getColorForStatus(notification.status),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          notification.message,
          style: const TextStyle(color: blackPrimary, fontSize: 15, height: 1.4),
        ),
      ),
    );
  }
}