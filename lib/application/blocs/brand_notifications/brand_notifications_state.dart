part of 'brand_notifications_bloc.dart';

sealed class BrandNotificationsState extends Equatable {
  const BrandNotificationsState();
  
  @override
  List<Object> get props => [];
}

final class BrandNotificationsInitial extends BrandNotificationsState {}
