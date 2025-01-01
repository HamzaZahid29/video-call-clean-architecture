import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Initialize Firebase and Notifications
   Future<void> initialize() async {
    await Firebase.initializeApp();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permissions (for iOS)
    await _firebaseMessaging.requestPermission();

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen(_onMessageReceived);

    // Handle messages when the app is in the background or terminated
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
  static Future<String?> getToken() async{
    return await _firebaseMessaging.getToken();
  }
  // Handle notification when the app is in the foreground
  static Future<void> _onMessageReceived(RemoteMessage message) async {
    print('Foreground message received: ${message.notification?.title}');
    _showNotification(message);
  }

  // Handle notification when the app is in the background or terminated
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print('Background message received: ${message.notification?.title}');
    await Firebase.initializeApp();
    _showNotification(message);
  }

  // Show notification using flutter_local_notifications
  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      channelDescription: 'This is the default notification channel.',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: 'Custom Data',
    );
  }
}
