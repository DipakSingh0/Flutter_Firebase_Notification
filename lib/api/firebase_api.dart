import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notif/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _notifications = FlutterLocalNotificationsPlugin();

// for stroing msg and navigating to notification page
  RemoteMessage? _pendingMessage;

  Future<void> initNotifications() async {
    // 1. Request permissions
    await _firebaseMessaging.requestPermission();

    // 2. Get token
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');

    // 3. Initialize local notifications
    await _initLocalNotifications();

    // 4. Initialize push notification handlers
    await initPushNotifications();
  }


  Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Navigate using stored message
        if (_pendingMessage != null) {
          navigatorKey.currentState?.pushNamed(
            '/notification_screen',
            arguments: _pendingMessage,
          );
          _pendingMessage = null; // Clear after navigation
        }
      },
    );
  }

// handles showing notification
Future<void> _showNotification(RemoteMessage message) async {
    // Store the message for use when notification is tapped
    _pendingMessage = message;

    final android = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(android: android),
    );
  }

   //  navigate to notification page while tapped
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future<void> initPushNotifications() async {
    // Handle terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle background state
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle foreground state - THIS WAS MISSING IN YOUR CODE
    FirebaseMessaging.onMessage.listen((message) {
      print('Foreground message received!');
      _showNotification(message); // Display notification
    });
  }
}
