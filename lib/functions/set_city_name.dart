import 'dart:math';
import 'package:azkar_app/service/shared.dart';
import 'package:location/location.dart';

Future<void> setCityName() async {
  Map cityData = await Shared.getCityData();

  // ✅ إذا كانت البيانات موجودة مسبقًا، لا تفعل شيء
  if (cityData.isNotEmpty) return;

  // ✅ تحميل بيانات المدن
  List cities = await Shared.loadCitiesList();

  // ✅ التحقق إذا كان الموقع مفعل، بدون طلب تفعيله
  bool serviceEnabled = await Location().serviceEnabled();

  if (serviceEnabled) {
    try {
      LocationData locationData = await Location().getLocation();
      double? currentLat = locationData.latitude;
      double? currentLong = locationData.longitude;

      if (currentLat != null && currentLong != null) {
        double minDistance = double.infinity;
        Map<String, dynamic>? nearestCity;

        for (var element in cities) {
          double cityLat = element['latitude'];
          double cityLong = element['longitude'];

          double distance = calculateDistance(
            currentLat,
            currentLong,
            cityLat,
            cityLong,
          );

          if (distance < minDistance) {
            minDistance = distance;
            nearestCity = element;
          }
        }

        if (nearestCity != null) {
          await Shared.saveCityData(nearestCity);
          return;
        }
      }
    } catch (e) {
      // ✅ السقوط إلى القاهرة إذا فشل الحصول على الموقع
      await _saveDefaultCairoCity(cities);
    }
  } else {
    // ✅ الموقع غير مفعل - تعيين القاهرة
    await _saveDefaultCairoCity(cities);
  }
}

Future<void> _saveDefaultCairoCity(List cities) async {
  for (var element in cities) {
    if (element['city'] == "القاهرة") {
      await Shared.saveCityData(element);
      break;
    }
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double R = 6371; // نصف قطر الأرض بالكيلومتر
  double dLat = _degToRad(lat2 - lat1);
  double dLon = _degToRad(lon2 - lon1);

  double a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_degToRad(lat1)) *
          cos(_degToRad(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _degToRad(double deg) {
  return deg * (pi / 180);
}

Future loadJsonCapital() async {
  List dataAll = [
    {"city": "الجزائر","isAdded":false, "latitude": 36.7525, "longitude": 3.0420},
    {"city": "المنامة","isAdded":false, "latitude": 26.2285, "longitude": 50.5861},
    {"city": "موروني", "isAdded":false,"latitude": -11.7000, "longitude": 43.2333},
    {"city": "جيبوتي","isAdded":false, "latitude": 11.5950, "longitude": 43.1481},
    {"city": "القاهرة","isAdded":false, "latitude": 30.0444, "longitude": 31.2357},
    {"city": "بغداد","isAdded":false, "latitude": 33.3152, "longitude": 44.3661},
    {"city": "عمان","isAdded":false, "latitude": 31.9539, "longitude": 35.9106},
    {"city": "الكويت","isAdded":false, "latitude": 29.3759, "longitude": 47.9774},
    {"city": "بيروت","isAdded":false, "latitude": 33.8938, "longitude": 35.5018},
    {"city": "طرابلس","isAdded":false, "latitude": 32.8872, "longitude": 13.1913},
    {"city": "نواكشوط","isAdded":false, "latitude": 18.0735, "longitude": -15.9582},
    {"city": "الرباط","isAdded":false, "latitude": 34.0209, "longitude": -6.8416},
    {"city": "مسقط","isAdded":false, "latitude": 23.5880, "longitude": 58.3829},
    {"city": "الدوحة","isAdded":false, "latitude": 25.276987, "longitude": 51.520008},
    {"city": "الرياض","isAdded":false, "latitude": 24.7136, "longitude": 46.6753},
    {"city": "الخرطوم","isAdded":false, "latitude": 15.5007, "longitude": 32.5599},
    {"city": "دمشق","isAdded":false, "latitude": 33.5138, "longitude": 36.2765},
    {"city": "تونس","isAdded":false, "latitude": 36.8065, "longitude": 10.1815},
    {"city": "أبو ظبي","isAdded":false, "latitude": 24.4667, "longitude": 54.3667},
    {"city": "صنعاء","isAdded":false, "latitude": 15.3694, "longitude": 44.1910},
    {"city": "رام الله","isAdded":false, "latitude": 31.8996, "longitude": 35.2042}
  ]
  ;
  await Shared.saveCitiesList(dataAll);
  print("done");
}
