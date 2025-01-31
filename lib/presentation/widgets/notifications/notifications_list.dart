import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/brand_notifications/brand_notifications_bloc.dart';
import 'package:gymnastic_center/presentation/screens/notifications/notification_detail_screen.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';

class NotificationsList extends StatelessWidget {
  final BrandNotificationsBloc notificationsBloc;
  const NotificationsList({super.key, required this.notificationsBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notificationsBloc.state.notifications.length,
      itemBuilder: (context, index) {
        final notification = notificationsBloc.state.notifications[index];
        return ListTile(
          onTap: () {
            notificationsBloc.add(NotificationRead(notification.id));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationDetailScreen(notification: notification)),
            );
          },
          tileColor: notification.isRead == false
              ? Theme.of(context).colorScheme.surfaceTint
              : Colors.transparent,
          contentPadding: const EdgeInsets.all(10),
          shape: index != notificationsBloc.state.notifications.length - 1
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
          trailing: Text(formatDateTime(notification.date)),
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
