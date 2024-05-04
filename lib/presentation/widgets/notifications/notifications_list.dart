import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/application/models/push_message.dart';
import 'package:gymnastic_center/infrastructure/screens/notifications/notification_detail_screen.dart';
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
          onTap: () {
            context
                .read<NotificationsBloc>()
                .add(NotificationViewed(notification));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationDetailScreen(notification: notification)),
            );
          },
          tileColor: notification.isViewed == false
              ? Theme.of(context).colorScheme.surfaceTint
              : Colors.transparent,
          contentPadding: const EdgeInsets.all(10),
          shape: index != notifications.length - 1
              ? Border(
                  bottom: BorderSide(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer))
              : null,
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold),
          leading: const Icon(Icons.notifications_rounded),
          trailing: Text(formatDateTime(notification.sentDate)),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              notification.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            notification.body,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        );
      },
    );
  }
}
