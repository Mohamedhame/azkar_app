import 'dart:developer';
import 'package:azkar_app/service/mawaqit_service.dart';
import 'package:azkar_app/service/noti_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  Future<void> init() async {
    try {
      await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    } catch (e) {
      log("Error initializing WorkManager: $e");
    }
  }

  //========================Hadith Task=====================
  Future<void> registerHadithNotificationTask(int remember) async {
    try {
      await Workmanager().registerPeriodicTask(
        "hadith",
        "hadith",
        frequency: Duration(minutes: remember),
      );
      log("Hadith notification task registered successfully.");
    } catch (e) {
      log("Error registering Hadith notification task: $e");
    }
  }

  //========================Prayers Task====================
  Future<void> registerPrayersTask() async {
    try {
      await Workmanager().registerPeriodicTask(
        "prayers",
        "prayers",
        frequency: const Duration(hours: 5),
      );
      log("prayers task registered successfully.");
    } catch (e) {
      log("Error registering prayers task: $e");
    }
  }

  //========================Cancel Task=====================
  Future<void> cancelTask(String id) async {
    try {
      await Workmanager().cancelByUniqueName(id);
      log("Task cancelled: $id");
    } catch (e) {
      log("Error cancelling task: $e");
    }
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    log("Native called background task: $task");
    await initNatification();
    tz.initializeTimeZones();
    switch (task) {
      case "hadith":
        await prayerBeUponProphet();
        break;

      case "prayers":
        await MawaqitService().getMoaquit();
        break;
      default:
    }

    return Future.value(true);
  });
}
