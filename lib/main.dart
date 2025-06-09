import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wird/routes.dart';
import 'package:workmanager/workmanager.dart';

// partie 1
AudioPlayer audioPlayer = AudioPlayer(); // تعريف مشغل الصوت

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) async {
  // التعامل مع الضغط على الزر عندما يكون التطبيق في الخلفية أو مغلق
  if (notificationResponse.actionId == 'close_action') {
    await audioPlayer.stop();
    print('تم الضغط على زر إغلاق في الخلفية');
  }
}

// Initialiser le service de fond
Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(),
  );
}

// Fonction exécutée dans le service de fond
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('playAdhan').listen((event) async {
      final prayerName = event?['prayerName'] ?? 'الصلاة';

      service.setForegroundNotificationInfo(
        title: 'أذان $prayerName',
        content: 'جاري تشغيل أذان $prayerName',
      );
      await audioPlayer.play(AssetSource('adhane/adhan.mp3'));
    });
  }
}

const myBackgroundJob = "myBackgroundJob";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final prayerName = inputData?['prayerName'] ?? 'الصلاة';
    print("🔔 الأذان لصلاة $prayerName ");

    // Play Adhan sound
    await audioPlayer.play(AssetSource('adhane/adhan.mp3'));

    // Show notification
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'adhan_channel',
      'أذان الصلاة',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      enableVibration: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'close_action',
          'إغلاق',
          icon: DrawableResourceAndroidBitmap('stop_7826834'),
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      0,
      'أذان $prayerName',
      'حان الآن وقت $prayerName',
      notificationDetails,
      payload: 'stop_7826834',
    );

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialiser le service de fond
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  await notificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: (response) {
      print('تم النقر على الإشعار: ${response.payload}');
      if (response.actionId == 'close_action') {
        audioPlayer.stop();
      }
    },
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mathani",
      getPages: pages,
    );
  }
}
