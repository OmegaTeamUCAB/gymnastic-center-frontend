import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/notifications/empty_notifications.dart';
import 'package:gymnastic_center/presentation/widgets/notifications/notifications_list.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
              content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  notifications.length.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Inbox',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<NotificationsBloc>()
                          .add(NotificationsCleared());
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
          )),
        ),
        body: notifications.isEmpty
            ? const EmptyNotifications()
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: NotificationsList(notifications: notifications),
              ));
  }
}
