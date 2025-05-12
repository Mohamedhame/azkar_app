import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ReadQuranCtrl extends ChangeNotifier {
  ReadQuranCtrl() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WakelockPlus.enable();
    init();
  }

  bool showBottomWidget = true;
  bool useDefaultAppBar = true;

  hideAppearAppBarAndBottom() {
    showBottomWidget = !showBottomWidget;
    useDefaultAppBar = !useDefaultAppBar;
    notifyListeners();
  }

  init() {
    FlutterQuran().init();
    notifyListeners();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
