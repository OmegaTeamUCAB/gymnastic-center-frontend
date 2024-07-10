import 'dart:convert';

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
        List<BrandNotification> notifications = [];
        for (var notification in data) {
          notifications.add(BrandNotification(
            id: notification['id'],
            title: notification['title'],
            body: notification['body'],
            date: DateTime.parse(notification['date']),
            isRead: notification['readed'],
          ));
        }
        return notifications;
      },
    );
    return result;
  }

  @override
  Future<Result<BrandNotification>> markAsRead(String id) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/one/$id',
      httpMethod: 'GET',
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
      httpMethod: 'DELETE',
      mapperCallBack: (data) {
        return null;
      },
    );
    return result;
  }

  @override
  Future<Result<void>> saveToken(String token) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/savetoken',
      body: jsonEncode({'token': token}),
      httpMethod: 'POST',
      mapperCallBack: (data) {
        return null;
      },
    );
    return result;
  }

  @override
  Future<Result<int>> getUnreadCount() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'notifications/count/not-readed',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        int count = 0;
        count = data['count'];
        return count;
      },
    );
    return result;
  }
}
