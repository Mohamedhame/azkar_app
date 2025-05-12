import 'package:azkar_app/service/web_scraping.dart';
import 'package:flutter/foundation.dart';
class NawayExplainCtrl extends ChangeNotifier {
  NawayExplainCtrl({required this.title}) {
    loadData();
  }
  final String title;
  Map dataJson = {};
  bool isLoading = false;
  String chapterTitle = "";
  String body = "";
  String explain = "";
  String rawy = "";

  loadData() async {
    isLoading = true;
    dataJson = await WebScraping.loadExplainNawawy(title);
    chapterTitle = dataJson['chapterTitle'];
    body = dataJson['body'];
    explain = dataJson['explain'];
    isLoading = false;
    rawy = dataJson['rawy'];
    notifyListeners();
  }
}
