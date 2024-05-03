import 'package:gymnastic_center/application/models/push_message.dart';

abstract class INotificationHandler {
  Future<void> initializeLocalNotifications();
  void setForegroundListener(Function(PushMessage) handler);
  void setBackgroundListener(Function(PushMessage) handler);
  void showLocalNotification(
      {required int id,
      String? title,
      String? body,
      Map<String, dynamic>? data});
  Future<bool> requestPermission();
  Future<bool> get isAuthorized;
  Future<String?> get token;
}
