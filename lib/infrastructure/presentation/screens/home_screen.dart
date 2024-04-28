import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/application/blocs/notifications/notifications_bloc.dart';
import 'package:flutter_template/infrastructure/presentation/screens/auth/login_screen.dart';
import 'package:flutter_template/infrastructure/presentation/screens/bloc_counter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('BLoC'),
            subtitle: const Text('Gestor de estado complejo'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BlocCounterScreen()),
            ),
          ),
          ListTile(
            onTap: () =>
                {context.read<NotificationsBloc>().requestPermission()},
            title: const Text('Permiso Notificaciones'),
            trailing: const Icon(Icons.notifications),
            subtitle: Text(
                'Permiso: ${context.select((NotificationsBloc bloc) => bloc.state.status)}'),
          ),
          ListTile(
            title: const Text('Login'),
            subtitle: const Text('Login Ui'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
          ),
          for (var notification in notifications)
            ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              leading: notification.imageUrl != null
                  ? Image(image: NetworkImage(notification.imageUrl!))
                  : null,
              trailing: const Icon(Icons.notifications_outlined),
            )
        ],
      ),
    );
  }
}
