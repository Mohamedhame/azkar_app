import 'package:azkar_app/service/web_scraping.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class ShowZekrBasedOnIndexingCtrl extends ChangeNotifier {
  ShowZekrBasedOnIndexingCtrl({required this.index}) {
    loadData();
  }
  final int index;
  List<int> press = [];
  List<double> perecent = [];
  List data = [];
  String? title;
  HijriCalendar format = HijriCalendar.now();
  DateTime now = DateTime.now();
  String? date;
  int? currentWeekday;
  List<String> weekday = [
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد",
  ];

  loadData() async {
    List dataAll = await WebScraping.loadJsonAzkar();
    data = dataAll[index]['array'];
    title = dataAll[index]['category'];
    press = List.generate(data.length, (_) => 0);
    perecent = List.generate(data.length, (_) => 0.0);
    date = now.toString().split(" ")[0];
    currentWeekday = now.weekday - 1;
    notifyListeners();
  }

  double incresePercent(int index) {
    int count = data[index]['count'];

    if (press[index] < count) {
      press[index]++;
      perecent[index] = press[index] / count;
      notifyListeners();
    } else {
      press[index] = 0;
      perecent[index] = 0.0;
      notifyListeners();
    }
    return perecent[index];
  }
}
