import 'package:azkar_app/service/web_scraping.dart';
import 'package:flutter/material.dart';

class ShowIndexOfAzkarCtrl extends ChangeNotifier {
  ShowIndexOfAzkarCtrl() {
    loadData();
  }
  List titleOfAzkar = [];
  bool isLoading = false;

  loadData() async {
    isLoading = true;
    titleOfAzkar = await WebScraping.loadJsonAzkar();
    isLoading = false;
    notifyListeners();
  }
}
