part of 'brand_notifications_bloc.dart';

sealed class BrandNotificationsEvent {
  const BrandNotificationsEvent();
}

class NotificationsRequested extends BrandNotificationsEvent {
  const NotificationsRequested();
}

class NotificationRead extends BrandNotificationsEvent {
  final String id;
  const NotificationRead(this.id);
}
