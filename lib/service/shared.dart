import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  //========= Determine the appearance of the phone, whether it is dark or light ==//
  static Future<void> setTheme(bool theme) async {
    await init();
    await _sharedPreferences!.setBool("theme", theme);
  }

  //=== Change the phone's appearance from dark to light and vice versa ========
  static Future<bool?> getTheme() async {
    await init();
    return _sharedPreferences!.getBool("theme");
  }

  static Future<void> setMusicQuran(Map<String, dynamic> value) async {
    await init();
    String jsonString = jsonEncode(value);
    await _sharedPreferences!.setString("save", jsonString);
    log("setMusicQuran");
  }

  static Future<Map<String, dynamic>?> getMusicQuran() async {
    await init();
    String? jsonString = _sharedPreferences!.getString('save');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> setMusicSira(Map<String, dynamic> value) async {
    await init();
    String jsonString = jsonEncode(value);
    await _sharedPreferences!.setString("sira", jsonString);
    log("setMusicSira");
  }

  static Future<Map<String, dynamic>?> getMusicSira() async {
    await init();
    String? jsonString = _sharedPreferences!.getString('sira');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> saveAzkar(List listOfZekr) async {
    await init();
    String encodedList = jsonEncode(listOfZekr);
    await _sharedPreferences!.setString('listOfZekr', encodedList);
  }

  static Future<List> getListOfZekr() async {
    await init();
    String? encodedList = _sharedPreferences!.getString('listOfZekr');

    if (encodedList != null) {
      List decoded = jsonDecode(encodedList);
      return decoded;
    }
    return [];
  }

  static Future<bool> runOnlyOnFirstInstall() async {
    await init();
    final hasInitialized =
        _sharedPreferences!.getBool('has_initialized') ?? false;

    if (hasInitialized) {
      return false;
    }

    await _sharedPreferences!.setBool('has_initialized', true);
    return true;
  }

  static Future<void> setFontSizeHadith(double value) async {
    await init();
    _sharedPreferences!.setDouble("font", value);
  }

  static Future<double> getFontSizeHadith() async {
    await init();
    double? font = _sharedPreferences!.getDouble("font");
    if (font != null) {
      return font;
    }
    return 16.0;
  }

  //============ Save data for a single city on a map =============
  static Future<void> saveCityData(Map city) async {
    await init();
    String encodedList = jsonEncode(city);
    await _sharedPreferences!.setString('city_data', encodedList);
  }

  //========= Get data for a single city from the map ========
  static Future<Map> getCityData() async {
    await init();
    String? data = _sharedPreferences!.getString("city_data");
    if (data != null) {
      Map decoded = jsonDecode(data);
      return decoded;
    }
    return {};
  }

  // ========== Save city data in a list ===========
  static Future<void> saveCitiesList(List city) async {
    await init();
    String encodedList = jsonEncode(city);
    await _sharedPreferences!.setString('city_list', encodedList);
  }

  //======= Get city data from list =================
  static Future<List<Map<String, dynamic>>> loadCitiesList() async {
    await init();
    String? encodedList = _sharedPreferences!.getString('city_list');
    if (encodedList != null) {
      List<dynamic> decoded = jsonDecode(encodedList);
      return decoded.cast<Map<String, dynamic>>();
    }

    return [];
  }

  //========== Does the user have prayer alerts enabled? ============
  static Future<void> setPrayer(bool value) async {
    await init();
    _sharedPreferences!.setBool("prayers", value);
  }

  //========= Answer the question: Does the user have prayer alerts enabled? =======
  static Future<bool> getPrayer() async {
    await init();
    bool? isPrayer = _sharedPreferences!.getBool("prayers");
    if (isPrayer != null) {
      return isPrayer;
    }
    return true;
  }

  //==========================================
  static Future<void> clearCityData() async {
    await init();
    await _sharedPreferences!.remove('city_data');
    await _sharedPreferences!.remove('city_list');
  }

  //===== Set the time period after which the alert will be sent. =========
  static Future<void> setRemeber(int value) async {
    await init();
    _sharedPreferences!.setInt("remeber", value);
  }

  //==== Get the time period after which the alert will be sent. ==========
  static Future<int> getRemeber() async {
    await init();
    int? remeber = _sharedPreferences!.getInt("remeber");
    if (remeber != null) {
      return remeber;
    }
    return 15;
  }

  //====== Is the user alert enabled or not?  ===============
  static Future<void> setIsReminder(bool value) async {
    await init();
    _sharedPreferences!.setBool("isRemender", value);
  }

  //============ Answer the question: Is the warning active or not? ========
  static Future<bool> getIsReminder() async {
    await init();
    bool? isRemender = _sharedPreferences!.getBool("isRemender");
    if (isRemender != null) {
      return isRemender;
    }
    return true;
  }
}
