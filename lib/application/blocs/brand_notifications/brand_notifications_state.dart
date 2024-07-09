part of 'brand_notifications_bloc.dart';

class BrandNotificationsState extends Equatable {
  final List<BrandNotification> notifications;
  final bool isLoading;

  const BrandNotificationsState(
      {required this.notifications, required this.isLoading});

  BrandNotificationsState copyWith({
    List<BrandNotification>? notifications,
    bool? isLoading,
  }) {
    return BrandNotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [notifications, isLoading];
}
