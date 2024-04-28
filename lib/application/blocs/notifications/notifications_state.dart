part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final bool status;
  final List<PushMessage> notifications;

  const NotificationsState({
    this.status = false,
    this.notifications = const [],
  });

  NotificationsState copyWith(
          {bool? status, List<PushMessage>? notifications}) =>
      NotificationsState(
          status: status ?? this.status,
          notifications: notifications ?? this.notifications);

  @override
  List<Object> get props => [status, notifications];
}
