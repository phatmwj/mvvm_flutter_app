import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi{
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async{
    AndroidInitializationSettings initializationAndroid =
    const AndroidInitializationSettings(
        '@mipmap/ic_launcher',);

    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (id, title, body, payload) {},
        );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroid,
      iOS: initializationIos
    );

    await notificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse: (details) {
      }
    );
  }

  Future<void> simpleNotificationShow(String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'channel_id',
            'channel_title',
          priority: Priority.high,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
          channelShowBadge: true,
          styleInformation: BigTextStyleInformation(
            body,
            htmlFormatBigText: true,
            htmlFormatContentTitle: true,
          ),
          //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher')
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );

    await notificationsPlugin.show(0, 'AllWin', body, notificationDetails, payload: 'xin chaoooo');
  }

}