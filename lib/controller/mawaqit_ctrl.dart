import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adhan/adhan.dart';
import 'package:azkar_app/functions/cancel_or_run_notification_prayers.dart';
import 'package:azkar_app/functions/format_duration.dart';
import 'package:azkar_app/functions/get_next_prayer_time.dart';
import 'package:azkar_app/functions/set_city_name.dart';
import 'package:azkar_app/service/shared.dart';
import 'package:azkar_app/view/page/mawaqit/cities.dart';
import 'package:azkar_app/view/page/mawaqit/mawaqit_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MawaqitCtrl extends ChangeNotifier {
  MawaqitCtrl() {
    getCityName();
    prayerTimesFunc();
  }

  int currentPage = 0;
  String cityName = "";
  List allCities = [];
  double? latitudeInShared;
  double? longitudeInShared;
  TextEditingController cityNameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final Location _location = Location();
  bool isPermission = false;
  bool isLoadingLocation = false;
  String prayrName = "صلاة";
  String remaining = "00:00";
  String timeOfPrayae = "00:00";
  bool isLoadingPrayers = false;
  PrayerTimes? prayerTimes;
  List prayers = [];
  Timer? _timer;

  final List<Widget> pages = [const MawaqitView(), const Cities()];

  changePage(int value) {
    currentPage = value;
    notifyListeners();
  }

  getCityName() async {
    Map cityData = await Shared.getCityData();
    cityName = cityData['city'];
    latitudeInShared = cityData['latitude'];
    longitudeInShared = cityData['longitude'];
    allCities = await Shared.loadCitiesList();
    notifyListeners();
  }

  Future<void> _getCityName(double lat, double lng) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&zoom=10',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        cityNameController.text =
            data['address']['city'] ??
            data['address']['town'] ??
            data['address']['village'] ??
            "موقع غير معروف";
      }
    } on SocketException {
      cityNameController.text = "النت مقطوع";
    } catch (e) {
      cityNameController.text = "فشل في جلب البيانات";
    }
  }

  Future<bool> checkAndRequestLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<void> getLocation() async {
    isPermission = false;
    isLoadingLocation = true;
    notifyListeners();

    try {
      if (await checkAndRequestLocationService()) {
        try {
          LocationData locationData = await Location().getLocation();
          double? latitude = locationData.latitude;
          double? longitude = locationData.longitude;

          latitudeController.text = latitude.toString();
          longitudeController.text = longitude.toString();
          await _getCityName(latitude!, longitude!);
          isPermission = true;
          notifyListeners();
        } catch (e) {
          print(e);
          isPermission = false;
          cityNameController.text = "فشل في تحديد الموقع";
        }
      } else {
        isPermission = false;
        notifyListeners();
      }
    } catch (e) {
      isPermission = false;
      cityNameController.text = "خطأ في الخدمة";

      notifyListeners();
    } finally {
      isLoadingLocation = false;
      notifyListeners();
    }
  }

  void addToDataList() async {
    var newData = {
      "city": cityNameController.text,
      "isAdded": true,
      "latitude": double.parse(latitudeController.text),
      "longitude": double.parse(longitudeController.text),
    };
    allCities.add(newData);
    await Shared.saveCitiesList(allCities);
    notifyListeners();
  }

  bool ifInShared(int index) {
    if (latitudeInShared == allCities[index]['latitude'] &&
        longitudeInShared == allCities[index]['longitude'] &&
        cityName == allCities[index]['city']) {
      return true;
    } else {
      return false;
    }
  }

  void deleteCityFromData(int index) async {
    if (ifInShared(index)) {
      await Shared.clearCityData();
      allCities.removeAt(index);
      await Shared.saveCitiesList(allCities);
      changePrayerState();
      await setCityName();
      getCityName();
    } else {
      allCities.removeAt(index);
      await Shared.saveCitiesList(allCities);
      notifyListeners();
    }
  }

  changePrayerState() async {
    await cancelNotificationPrayers();
    //================
    await runNotificationPrayers();
    prayerTimesFunc();
  }

  prayerTimesFunc() async {
    isLoadingPrayers = true;
    Map d = await Shared.getCityData();
    double latitude = d['latitude'];
    double longitude = d['longitude'];
    Coordinates coordinates = Coordinates(latitude, longitude);
    CalculationParameters params = CalculationMethod.egyptian.getParameters();
    prayerTimes = PrayerTimes.today(coordinates, params);
    List prayersData = [
      {
        "prayerName": "الفجر",
        "time": formatTime(prayerTimes!.fajr.hour, prayerTimes!.fajr.minute),
      },
      {
        "prayerName": "الشروق",
        "time": formatTime(
          prayerTimes!.sunrise.hour,
          prayerTimes!.sunrise.minute,
        ),
      },
      {
        "prayerName": "الظهر",
        "time": formatTime(prayerTimes!.dhuhr.hour, prayerTimes!.dhuhr.minute),
      },
      {
        "prayerName": "العصر",
        "time": formatTime(prayerTimes!.asr.hour, prayerTimes!.asr.minute),
      },
      {
        "prayerName": "المغرب",
        "time": formatTime(
          prayerTimes!.maghrib.hour,
          prayerTimes!.maghrib.minute,
        ),
      },
      {
        "prayerName": "العشاء",
        "time": formatTime(prayerTimes!.isha.hour, prayerTimes!.isha.minute),
      },
    ];
    prayers = prayersData;
    isLoadingPrayers = false;
    notifyListeners();
    startNextPrayerUpdater();
  }

  nextPrayer() {
    final result = getNextPrayerTime({
      "صلاة الفجر": prayerTimes!.fajr,
      "صلاة الظهر": prayerTimes!.dhuhr,
      "صلاة العصر": prayerTimes!.asr,
      "صلاة المغرب": prayerTimes!.maghrib,
      "صلاة العشاء": prayerTimes!.isha,
    });
    remaining = formatDuration(result['remaining']);
    prayrName = result['name'];
    timeOfPrayae = formatTime(result['time'].hour, result['time'].minute);
  }

  void startNextPrayerUpdater() {
    nextPrayer();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      nextPrayer();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
