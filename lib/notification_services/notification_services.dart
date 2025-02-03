import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/controller/bottom_bar/bottom_bar_controller.dart';

class NotificationService extends GetxService {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<NotificationService> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    await _requestPermissions();

    _firebaseMessaging.getToken().then((String? token) {
      print("FCM Token: $token");
    });

    // Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Background message handling
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageOpen(message);
    });

    // Handle messages when the app is terminated
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpen(initialMessage);
    }

    return this;
  }

  Future<void> _requestPermissions() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    /// Get Image method to show notification
    String? imageUrl = message.notification?.android?.imageUrl ?? '';
    final http.Response response = await http.get(Uri.parse(imageUrl));
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(response.bodyBytes)));

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      visibility: NotificationVisibility.private,
      sound: const RawResourceAndroidNotificationSound("notification"),

      /// Show image in notifications
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.notification?.body),
    );
    print("Notifications Data : ${message.notification!.body}");
    print("Notifications Data : ${message.notification?.android?.imageUrl}");
  }

  Future<void> _handleMessageOpen(RemoteMessage message) async {
    final bottomBarController =
        Get.put<BottomBarController>(BottomBarController());
    final String? payload = message.notification?.body;

    if (payload != null && payload.isNotEmpty) {
      String removeSpacePayloadData = payload.replaceAll('"', '').trim();
      if (removeSpacePayloadData == 'Categories') {
        bottomBarController.selectedIndex.value = 1;
      }
      debugPrint('Notification payload: $payload');
    } else {
      debugPrint('No valid payload received.');
    }
    bottomBarController.update();
  }

  Future<void> _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final bottomBarController =
        Get.put<BottomBarController>(BottomBarController());
    final String? payload = notificationResponse.payload;

    // Check if there is a valid payload and process it
    if (payload != null && payload.isNotEmpty) {
      String removeSpacePayloadData = payload.replaceAll('"', '').trim();
      if (removeSpacePayloadData == 'Categories') {
        bottomBarController.selectedIndex.value = 1;
      }
      debugPrint('Notification payload: $payload');
    } else {
      debugPrint('No valid payload received.');
    }

    bottomBarController.update();
  }
}
