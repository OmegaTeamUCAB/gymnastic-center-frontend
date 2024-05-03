import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/push_message.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';

class NotificationsList extends StatelessWidget {
  final List<PushMessage> notifications;
  const NotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          tileColor: const Color.fromARGB(18, 78, 20, 160),
          contentPadding: const EdgeInsets.all(10),
          shape: const Border(bottom: BorderSide(color: Colors.grey)),
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          leading: const Icon(Icons.notifications_rounded),
          trailing: Text(formatDateTime(notification.sentDate)),
          title: Text(notification.title),
          subtitle: Text(notification.body),
        );
      },
    );
  }
}
