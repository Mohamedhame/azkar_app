import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:azkar_app/controller/naway_explain_ctrl.dart';
import 'package:azkar_app/controller/show_zekr_based_on_indexing_ctrl.dart';
import 'package:azkar_app/functions/clean_text.dart';
import 'package:azkar_app/main.dart';
import 'package:azkar_app/view/page/hadith/naway_hadith_explain.dart';
import 'package:azkar_app/view/page/hadith/show_zekr_based_on_indexing.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notificationsPlugin = FlutterLocalNotificationsPlugin();
bool _isInitialized = false;
bool get isInitialized => _isInitialized;

// INITIALIZE
Future<void> initNatification() async {
  try {
    tz.initializeTimeZones();

    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'zad',
      'zad',
      description: 'Channel for zekr Notifications',
      importance: Importance.high,
      playSound: true,
      showBadge: true,
    );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await requestNotificationPermission();
    bool isPermission = await requestExactAlarmPermission();
    if (isPermission) {
      debugPrint("Exact alarm permission granted.");
    } else {
      debugPrint("Exact alarm permission denied.");
    }
  } catch (e) {
    debugPrint("Error initializing notifications: $e");
  }
}

//====================================
Future<void> requestNotificationPermission() async {
  final isNotificationsEnabled =
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled() ??
      false;

  if (!isNotificationsEnabled) {
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  if (await Permission.notification.isDenied) {
    final status = await Permission.notification.request();
    if (status.isDenied) {
      debugPrint("Notification permission denied by user.");
    } else if (status.isGranted) {
      debugPrint("Notification permission granted.");
    }
  }
}

//====================================
Future<bool> requestExactAlarmPermission() async {
  if (Platform.isAndroid) {
    final build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      var status = await Permission.scheduleExactAlarm.status;
      if (!status.isGranted) {
        status = await Permission.scheduleExactAlarm.request();
      }
      return status.isGranted;
    }
  }
  return true;
}

// show Notification
@pragma('vm:entry-point')
Future<void> prayerBeUponProphet() async {
  debugPrint("prayerBeUponProphet call");
  List hadith = [];
  for (var element in await loadJsonHadithNawawy()) {
    hadith.add({"title": element['chapterTitle'], "text": element['body']});
  }

  if (hadith.isEmpty) {
    debugPrint("قائمة الأحاديث فارغة، لا يمكن عرض الإشعار.");
    return;
  }

  hadith.shuffle();
  String nuseText = hadith[0]['text'].toString();
  String titleText = hadith[0]['title'].toString();

  try {
    final androidDetails = AndroidNotificationDetails(
      "id_1",
      "Basic Notification",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('song'),
      styleInformation: BigTextStyleInformation(
        nuseText,
        contentTitle: titleText,
        summaryText: titleText,
      ),
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      0,
      titleText,
      nuseText,
      notificationDetails,
      payload: titleText,
    );
  } catch (e, stackTrace) {
    debugPrint("Error notification: $e");
    debugPrint("Stack trace: $stackTrace");
  }
}

//==========================================
@pragma('vm:entry-point')
Future<void> showPrayerScheduledNotification({
  required String channelId,
  required int id,
  required int hour,
  required int minte,
  required String titleBody,
  required String sound,
}) async {
  try {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      channelId,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
      sound: RawResourceAndroidNotificationSound(sound),
    );

    NotificationDetails details = NotificationDetails(android: androidDetails);
    tz.initializeTimeZones();
    final String currentLocation = await FlutterTimezone.getLocalTimezone();
    log(currentLocation);
    tz.setLocalLocation(tz.getLocation(currentLocation));
    //================================================
    var currentTime = tz.TZDateTime.now(tz.local);
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hour,
      minte,
    );
    //=====================================================
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
    }
    //=================================================
    final duration = scheduleTime.difference(currentTime);
    log(
      "الوقت المتبقي حتى الإشعار $titleBody: ${duration.inHours} ساعة و ${duration.inMinutes % 60} دقيقة",
    );

    //===================================================
    await notificationsPlugin.zonedSchedule(
      id,
      titleBody,
      titleBody,
      scheduleTime,
      details,
      payload: channelId,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  } catch (e, stackTrace) {
    log("Error scheduling notification: $e");
    log("Stack trace: $stackTrace");
  }
}

Future<void> cancelNotification(int id) async {
  try {
    await notificationsPlugin.cancel(id);
    print('تم إلغاء الإشعار برقم $id');
  } catch (e) {
    print('حدث خطأ أثناء إلغاء الإشعار: $e');
  }
}

@pragma('vm:entry-point')
void onTap(NotificationResponse notificationResponse) async {
  if (notificationResponse.id == 0) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder:
            (_) => ChangeNotifierProvider(
              create:
                  (context) =>
                      NawayExplainCtrl(title: notificationResponse.payload!),
              child: NawayHadithExplain(),
            ),
      ),
    );
  }
  if (notificationResponse.id == 6 || notificationResponse.id == 7) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder:
            (_) => ChangeNotifierProvider(
              create: (context) => ShowZekrBasedOnIndexingCtrl(index: 0),
              child: ShowZekrBasedOnIndexing(),
            ),
      ),
    );
  }
}

Future<List> loadJsonHadithNawawy() async {
  List hadith = [];

  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/hadiths.json');

  if (!await file.exists()) {
    debugPrint("ملف الأحاديث غير موجود في التخزين");
    return hadith;
  }

  final jsonString = await file.readAsString();
  final data = json.decode(jsonString);
  List dataAll = data['1'];
  for (var element in dataAll) {
    hadith.add({
      "chapterTitle": cleanHadithBody(element['hadith'][1]['chapterTitle']),
      "body": cleanHadithBody(element['hadith'][1]['body']),
      "id": element['id'],
    });
  }
  hadith.sort((a, b) => a['id'].compareTo(b['id']));
  return hadith;
}

