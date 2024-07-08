import 'package:gymnastic_center/application/repositories/notifications/notification_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class NotificationRepository implements INotificationRepository {
  final IHttpManager _httpConnectionManager;

  NotificationRepository(this._httpConnectionManager);

  @override
  Future<Result<void>> deleteNotifications() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/delete/all',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        return null;
      },
    );
    return result;
  }

  @override
  Future<Result<List<BrandNotification>>> getNotifications() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/many',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<BrandNotification> notification = [];
        for (var notification in data) {
          notification.add(BrandNotification(
            id: notification['id'],
            title: notification['title'],
            body: notification['body'],
            date: notification['date'],
            isRead: notification['isRead'],
          ));
        }
        return notification;
      },
    );
    return result;
  }

  @override
  Future<Result<BrandNotification>> markAsRead(String id) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/one/$id',
      httpMethod: 'PATCH',
      mapperCallBack: (data) {
        return BrandNotification(
          id: data['id'],
          title: data['title'],
          body: data['body'],
          date: data['date'],
        );
      },
    );
    return result;
  }

  @override
  Future<Result<void>> removeToken() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/removetoken',
      body: {},
      httpMethod: 'POST',
      mapperCallBack: (data) {
        return null;
      },
    );
    return result;
  }

  @override
  Future<Result<void>> saveToken() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/savetoken',
      body: {},
      httpMethod: 'POST',
      mapperCallBack: (data) {
        return null;
      },
    );
    return result;
  }
}
