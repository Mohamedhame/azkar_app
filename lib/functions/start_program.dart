import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/service/shared.dart';

Future<void> startProgram() async {
  final isFirstInstall = await Shared.runOnlyOnFirstInstall();
  if (isFirstInstall) {
    CounterCtrl().saveAzkarInShred();
  }
}
