import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gymnastic_center/application/models/push_message.dart';
import 'package:gymnastic_center/application/services/notifications/notification_handler.dart';

class NotificationHandler implements INotificationHandler {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> _requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  PushMessage _mapMessage(RemoteMessage message) {
    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);
    return notification;
  }

  @override
  Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  @override
  Future<bool> requestPermission() async {
    final settingsStatus = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    await _requestPermissionLocalNotifications();
    return settingsStatus.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<bool> get isAuthorized async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<String?> get token async {
    return await _messaging.getToken();
  }

  @override
  void showLocalNotification({
    required int id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName',
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        priority: Priority.high);

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data.toString());
  }

  @override
  void setForegroundListener(handle) {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification == null) return;
      final notification = _mapMessage(message);
      handle(notification);
    });
  }

  @override
  Future<void> setBackgroundListener(Function(PushMessage) handle) async {
    await _messaging.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = _mapMessage(message);
      handle(notification);
      //do something (go to a screen, etc.)
    });
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = json.decode(response.payload.toString());
    payload.forEach((key, value) {});
    //do something (go to a screen, etc.)
  }
}
