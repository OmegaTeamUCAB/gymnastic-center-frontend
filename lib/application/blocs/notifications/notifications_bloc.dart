import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/models/push_message.dart';
import 'package:gymnastic_center/application/services/notifications/notification_handler.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  INotificationHandler handler;

  NotificationsBloc({
    required this.handler,
  }) : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);
    on<NotificationViewed>(viewNotification);

    // Verifies notifications state
    _initialStatusCheck();

    // Listener for foreground notifications
    _setForegroundListener();

    // Listener for background notifications
    _setBackgroundListener();
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  void _initialStatusCheck() async {
    add(NotificationStatusChanged(await handler.isAuthorized));
  }

  void _setForegroundListener() {
    handler.setForegroundListener((PushMessage message) {
      handler.showLocalNotification(
        id: message.hashCode,
        title: message.title,
        body: message.body,
        data: message.data,
      );
      add(NotificationReceived(message));
    });
  }

  void _setBackgroundListener() {
    handler.setBackgroundListener((PushMessage message) {
      add(NotificationReceived(message));
    });
  }

  void requestPermission() async {
    final status = await handler.requestPermission();
    add(NotificationStatusChanged(status));
  }

  void viewNotification(
    NotificationViewed event,
    Emitter<NotificationsState> emit,
  ) {
    final currentState = state;
    final updatedNotifications = currentState.notifications
        .map(
          (notification) =>
              notification.messageId == event.pushMessage.messageId
                  ? PushMessage(
                      messageId: notification.messageId,
                      title: notification.title,
                      body: notification.body,
                      sentDate: notification.sentDate,
                      data: notification.data,
                      isViewed: true,
                      imageUrl: notification.imageUrl,
                    )
                  : notification,
        )
        .toList();
    emit(state.copyWith(notifications: updatedNotifications));
  }
}
