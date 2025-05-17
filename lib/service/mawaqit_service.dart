import 'package:adhan/adhan.dart';
import 'package:azkar_app/functions/set_city_name.dart';
import 'package:azkar_app/service/noti_service.dart';
import 'package:azkar_app/service/shared.dart';



class MawaqitService {
  Future<void> getMoaquit() async {
    await setCityName();
    Map d = await Shared.getCityData();
    double latitude = d['latitude'];
    double longitude = d['longitude'];
    Coordinates coordinates = Coordinates(latitude, longitude);
    CalculationParameters params = CalculationMethod.egyptian.getParameters();
    PrayerTimes prayerTimes = PrayerTimes.today(coordinates, params);

    //=============== Fajer =================
    showPrayerScheduledNotification(
      channelId: "fajr",
      id: 1,
      hour: prayerTimes.fajr.hour,
      minte: prayerTimes.fajr.minute,
      titleBody: "الفجر",
      sound: "adhan",
    );
    //============ Dhuhr ===========
    showPrayerScheduledNotification(
      channelId: "dhuhr",
      id: 2,
      hour: prayerTimes.dhuhr.hour,
      minte: prayerTimes.dhuhr.minute,
      titleBody: "الظهر",
      sound: "adhan",
    );
    //============ Asr ===========
    showPrayerScheduledNotification(
      channelId: "asr",
      id: 3,
      hour: prayerTimes.asr.hour,
      minte: prayerTimes.asr.minute,
      titleBody: "العصر",
      sound: "adhan",
    );
    //============ Maghrib ===========
    showPrayerScheduledNotification(
      channelId: "maghrib",
      id: 4,
      hour: prayerTimes.maghrib.hour,
      minte: prayerTimes.maghrib.minute,
      titleBody: "المغرب",
      sound: "adhan",
    );
    //============ Isha ===========
    showPrayerScheduledNotification(
      channelId: "isha",
      id: 5,
      hour: prayerTimes.isha.hour,
      minte: prayerTimes.isha.minute,
      titleBody: "العشاء",
      sound: "adhan",
    );
    //============= Azkar Sbah ================
    showPrayerScheduledNotification(
      channelId: "morning",
      id: 6,
      hour: prayerTimes.fajr.hour + 1,
      minte: prayerTimes.fajr.minute + 30,
      titleBody: "اذكار لصباح",
      sound: "azkar",
    );
    //============= Azkar Messa ================
    showPrayerScheduledNotification(
      channelId: "evening",
      id: 7,
      hour: prayerTimes.asr.hour + 1,
      minte: prayerTimes.asr.minute + 30,
      titleBody: "أذكار المساء",
      sound: "msaa",
    );
  }
}
