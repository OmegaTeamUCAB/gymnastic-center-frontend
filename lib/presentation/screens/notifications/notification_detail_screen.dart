import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class NotificationDetailScreen extends StatelessWidget {
  final BrandNotification notification;
  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  BrandBackButton(),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              formatDateTime(notification.date),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(notification.body),
          ],
        ),
      ),
    );
  }
}
