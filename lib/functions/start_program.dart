import 'package:azkar_app/controller/counter_ctrl.dart';
import 'package:azkar_app/functions/copy_hadith_to_json_file.dart';
import 'package:azkar_app/functions/set_city_name.dart';
import 'package:azkar_app/service/mawaqit_service.dart';
import 'package:azkar_app/service/noti_service.dart';
import 'package:azkar_app/service/shared.dart';
import 'package:azkar_app/service/work_manager_service.dart';

Future<void> startProgram() async {
  final isFirstInstall = await Shared.runOnlyOnFirstInstall();
  if (isFirstInstall) {
    await copyHadithJsonToFile();
    CounterCtrl().saveAzkarInShred();
    await loadJsonCapital();
    int remember = await Shared.getRemeber();
    prayerBeUponProphet();
    Future.wait([
      WorkManagerService().registerHadithNotificationTask(remember),
      WorkManagerService().registerPrayersTask(),
      MawaqitService().getMoaquit(),
      setCityName(),
    ]);
  }
}
