import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/notifications/notifications_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/location/save_location.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final notifications =
    context.watch<NotificationsBloc>().state.notifications;
    return const Scaffold(body: SaveLocation());
  }
}
