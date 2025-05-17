import 'package:azkar_app/service/shared.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
ThemeController() {
    _loadTheme();
  }

  // الألوان
  Color _primaryColor = const Color(0xff202020);
  Color _fontColor = const Color(0xfffaf7f3);
  Color _secondaryColor = const Color(0xff2e2e2e); // لون ثانوي داكن
  bool _isLight = false;

  // Getters
  Color get primaryColor => _primaryColor;
  Color get fontColor => _fontColor;
  Color get secondaryColor => _secondaryColor;
  bool get isLight => _isLight;

  // Setter
  set isLight(bool l) {
    _isLight = l;
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    bool? isLight = await Shared.getTheme();
    _applyTheme(isLight ?? true);
  }

  void toggleTheme() async {
    bool? isLight = await Shared.getTheme();
    bool newTheme = !(isLight ?? true);
    await Shared.setTheme(newTheme);
    _applyTheme(newTheme);
  }

  void _applyTheme(bool theme) {
    if (theme) {
      // Light Theme
      _primaryColor = const Color(0xfffaf7f3);
      _fontColor = const Color(0xff202020);
      _secondaryColor = const Color(0xffe0ddd8); // رمادي فاتح ناعم
    } else {
      // Dark Theme
      _primaryColor = const Color(0xff202020);
      _fontColor = const Color(0xfffaf7f3);
      _secondaryColor = const Color(0xff2e2e2e); // رمادي غامق مريح للعين
    }
    isLight = theme;
  }

    //========================
  double _fontSize = 16.0;

  double get fontSize => _fontSize;

  Future<void> loadFontSize() async {
    _fontSize = await Shared.getFontSizeHadith();
    notifyListeners();
  }

  Future<void> setFontSize(double f) async {
    _fontSize = f;
    await Shared.setFontSizeHadith(f);
    notifyListeners();
  }

  decreaseFontSize() {
    if (_fontSize > 13) {
      _fontSize--;
      Shared.setFontSizeHadith(_fontSize);
      notifyListeners();
    }
  }

  increaseFontSize() {
    if (_fontSize < 69) {
      _fontSize++;
      Shared.setFontSizeHadith(_fontSize);
      notifyListeners();
    }
  }

  onChangedFontSize(double value) {
    _fontSize = value;
    Shared.setFontSizeHadith(_fontSize);
    notifyListeners();
  }

}
