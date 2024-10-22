part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final bool status;
  NotificationStatusChanged(this.status);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage pushMessage;

  NotificationReceived(this.pushMessage);
}

class NotificationViewed extends NotificationsEvent {
  final PushMessage pushMessage;

  NotificationViewed(this.pushMessage);
}

class NotificationsCleared extends NotificationsEvent {
  NotificationsCleared();
}
