import 'package:gymnastic_center/core/result.dart';

class BrandNotification {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool? isRead;

  const BrandNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.isRead,
  });
}

abstract class INotificationRepository {
  Future<Result<BrandNotification>> markAsRead(String id);
  Future<Result<int>> getUnreadCount();
  Future<Result<List<BrandNotification>>> getNotifications();
  Future<Result<void>> saveToken(String token);
  Future<Result<void>> removeToken(String token);
  Future<Result<void>> deleteNotifications();
}
