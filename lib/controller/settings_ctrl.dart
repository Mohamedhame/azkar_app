import 'package:azkar_app/functions/cancel_or_run_notification_prayers.dart';
import 'package:azkar_app/service/noti_service.dart';
import 'package:azkar_app/service/shared.dart';
import 'package:azkar_app/service/work_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsCtrl extends ChangeNotifier {
  SettingsCtrl() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initialValues();
  }
  String titleRemeber = "تشغيل";
  String titlePrayer = "تشغيل";
  WorkManagerService workManagerService = WorkManagerService();
  double valueOnSlider = 15.0;
  initialValues() async {
    int remember = await Shared.getRemeber();
    valueOnSlider = remember.toDouble();
    bool isRemeberRun = await Shared.getIsReminder();
    titleRemeber = isRemeberRun ? "إيقاف" : "تشغيل";
    bool isPrayer = await Shared.getPrayer();
    titlePrayer = isPrayer ? "إيقاف" : "تشغيل";
    notifyListeners();
  }

  changeValueOnSlider(double newValue) {
    valueOnSlider = newValue;
    notifyListeners();
  }

  increase5Minuts() {
    if (valueOnSlider < 55) {
      valueOnSlider += 5.0;
      notifyListeners();
    }
    if (valueOnSlider < 59) {
      valueOnSlider += 1.0;
      notifyListeners();
    }
  }

  decrease5Minuts() {
    if (valueOnSlider > 20) {
      valueOnSlider -= 5.0;
      notifyListeners();
    }

    if (valueOnSlider > 16) {
      valueOnSlider -= 1.0;
      notifyListeners();
    }
  }

  Future<bool> isRemeber() async {
    bool isRemeberRun = await Shared.getIsReminder();
    return isRemeberRun;
  }

  stopRemember() async {
    await Shared.setIsReminder(false);
    titleRemeber = "تشغيل";
    workManagerService.cancelTask("hadith");
    notifyListeners();
  }

  playRemeber() async {
    prayerBeUponProphet();
    int value = valueOnSlider.toInt();
    await Shared.setRemeber(value);
    await Shared.setIsReminder(true);
    workManagerService.registerHadithNotificationTask(value);
    titleRemeber = "إيقاف";
    notifyListeners();
  }

  changePrayerState() async {
    bool isPrayer = await Shared.getPrayer();
    if (isPrayer) {
      await cancelNotificationPrayers();
      titlePrayer = "تشغيل";
      notifyListeners();
    } else {
      await runNotificationPrayers();
      titlePrayer = "إيقاف";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
