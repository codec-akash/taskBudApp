import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[400],
  accentColor: Colors.deepOrangeAccent,
  backgroundColor: Colors.blue[200],
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[800],
  accentColor: Colors.deepOrangeAccent,
  backgroundColor: Colors.blueGrey[800],
  secondaryHeaderColor: Colors.blue[700],
  unselectedWidgetColor: Colors.grey,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
