import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/push_message.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class NotificationDetailScreen extends StatelessWidget {
  final PushMessage notification;
  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    )),
                const Text(
                  'Notification',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              notification.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(notification.body),
            if (notification.imageUrl != null)
              Image.network(notification.imageUrl!)
          ],
        ),
      ),
    );
  }
}
