import 'package:gymnastic_center/core/result.dart';

class BrandNotification {
  final String id;
  final String title;
  final String body;
  final String date;
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
  Future<Result<List<BrandNotification>>> getNotifications();
  Future<Result<void>> saveToken(String token);
  Future<Result<void>> removeToken();
  Future<Result<void>> deleteNotifications();
}
