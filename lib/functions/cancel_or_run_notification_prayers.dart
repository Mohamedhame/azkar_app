import 'package:azkar_app/service/mawaqit_service.dart';
import 'package:azkar_app/service/noti_service.dart';
import 'package:azkar_app/service/shared.dart';
import 'package:azkar_app/service/work_manager_service.dart';

Future<void> cancelNotificationPrayers() async {
  WorkManagerService().cancelTask("prayers");
  Future.wait([
    cancelNotification(1),
    cancelNotification(2),
    cancelNotification(3),
    cancelNotification(4),
    cancelNotification(5),
    Shared.setPrayer(false),
  ]);
}

Future<void> runNotificationPrayers() async {
  await MawaqitService().getMoaquit();
  WorkManagerService().registerPrayersTask();
  await Shared.setPrayer(true);
}
