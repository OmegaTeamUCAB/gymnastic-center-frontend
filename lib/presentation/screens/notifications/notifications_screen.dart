import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/brand_notifications/brand_notifications_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/notifications/empty_notifications.dart';
import 'package:gymnastic_center/presentation/widgets/notifications/notifications_list.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    final notificationsBloc =
        BlocProvider.of<BrandNotificationsBloc>(context, listen: false);
    notificationsBloc.add(const NotificationsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandNotificationsBloc, BrandNotificationsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 100),
              child: CustomAppBar(
                  content: Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.notifications,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      state.notifications.length.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppLocalizations.of(context)!.inbox,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read().add(const NotificationsDeleted());
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
              )),
            ),
            body: state.notifications.isEmpty
                ? const EmptyNotifications()
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: NotificationsList(notificationsBloc: context.read()),
                  ));
      },
    );
  }
}
