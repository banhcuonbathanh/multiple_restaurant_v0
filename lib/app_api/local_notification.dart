import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );
    await _localNotificationService.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void onSelectNotification(String? payload) {
    print('payload ${payload}');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }

  Future<NotificationDetails> _notificationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'chanel_id',
      'chanel_name',
      channelDescription: 'description',
      importance: Importance.max,
      playSound: true,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail);
  }

  Future<void> showNotificationPayLoad(
      {required int id,
      required String title,
      required String body,
      required String payLoad}) async {
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail,
        payload: payLoad);
  }
}
