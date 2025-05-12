import 'package:azkar_app/service/web_scraping.dart';
import 'package:flutter/material.dart';

class ShowHadithCtrl extends ChangeNotifier {
  ShowHadithCtrl({required this.bookName}) {
    loadHadithBooks();
    loadHadith();
  }
  final String bookName;
  List hadithBooks = [];
  List hadith = [];
  bool isLoading = false;
  int currentIndex = 1;
  bool textLoading = false;
  bool isNaway = false;
  PageController pageController = PageController();

  changeCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  loadHadithBooks() async {
    isLoading = true;
    isNaway = bookName == "nawawy";
    hadithBooks = await WebScraping.loadJsonIndex(bookName);
    isLoading = false;
    notifyListeners();
  }

  loadHadith() async {
    textLoading = true;
    hadith = await WebScraping.fetchHadith(bookName, currentIndex);
    textLoading = false;
    notifyListeners();
  }

  jumpToPage(int index) {
    currentIndex = index;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }
}
