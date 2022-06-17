import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bar_gym/utils/colors.dart';
import 'package:the_bar_gym/utils/enums.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: MyColors.primaryColor,
  accentColor: MyColors.accentColor,
  primarySwatch: Colors.deepPurple,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: MyColors.primaryColor,
  accentColor: MyColors.accentColor,
  primarySwatch: Colors.deepPurple,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "AppTheme";

  AppTheme? appTheme;

  ThemeNotifier() {
    appTheme = AppTheme.light;
    getThemeFromPrefs();
  }

  toggleAppTheme(AppTheme? appTheme) {
    this.appTheme = appTheme;
    saveThemeToPrefs();
    notifyListeners();
  }

  getThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefsData = prefs.getString(key);
    //this.appTheme =
    appThemeEnumFromString(prefsData);
    notifyListeners();
  }

  saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, appTheme.toString());
  }

  void appThemeEnumFromString(String? value) {
    //return AppTheme.values.firstWhere((e) => e.toString() == value);
    for (var element in AppTheme.values) {
      if (element.toString() == value) {
        appTheme = element;
      }
    }
    notifyListeners();
  }

  ThemeMode themeModeFromEnum() {
    if (appTheme == AppTheme.light) {
      return ThemeMode.light;
    } else if (appTheme == AppTheme.dark) {
      return ThemeMode.dark;
    } else if (appTheme == AppTheme.system) {
      return ThemeMode.system;
    } else {
      return ThemeMode.light;
    }
  }
}
