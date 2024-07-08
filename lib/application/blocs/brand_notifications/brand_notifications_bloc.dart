import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/application/use_cases/notifications/get_notifications.use_case.dart';
import 'package:gymnastic_center/application/use_cases/notifications/read_notification.use_case.dart';

part 'brand_notifications_event.dart';
part 'brand_notifications_state.dart';

class BrandNotificationsBloc
    extends Bloc<BrandNotificationsEvent, BrandNotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final ReadNotificationUseCase readNotificationUseCase;
  BrandNotificationsBloc(
      this.getNotificationsUseCase, this.readNotificationUseCase)
      : super(const BrandNotificationsState(
            notifications: [], isLoading: false)) {
    on<NotificationsRequested>(_getNotifications);
    on<NotificationRead>(_readNotification);
  }

  Future _getNotifications(NotificationsRequested event,
      Emitter<BrandNotificationsState> emit) async {
    emit(state.copyWith(isLoading: true));
  }

  Future _readNotification(
      NotificationRead event, Emitter<BrandNotificationsState> emit) async {
    emit(state.copyWith(isLoading: true));
  }
}
