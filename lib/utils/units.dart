import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bar_gym/utils/enums.dart';

class UnitsNotifier extends ChangeNotifier {
  final String weightUnitKey = "weightUnit";

  // String weightUnit;
  WeightUnit? weightUnit;

  UnitsNotifier() {
    weightUnit = WeightUnit.kg;
    getWeightUnitFromPrefs();
  }

  toggleWeightUnit(WeightUnit? choice) {
    weightUnit = choice;
    saveWeightUnitToPrefs();
    notifyListeners();
  }

  getWeightUnitFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefsData = prefs.getString(weightUnitKey);
    //weightUnit = weightEnumFromString(prefsData);
    weightEnumFromString(prefsData);
    notifyListeners();
  }

  saveWeightUnitToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(weightUnitKey, weightUnit.toString());
  }

  void weightEnumFromString(String? value) {
    //return WeightUnit.values.firstWhere((e) => e.toString() == value);
    for (var element in WeightUnit.values) {
      if (element.toString() == value) {
        weightUnit = element;
      }
    }
    notifyListeners();
  }

// function to display date according to the units set by
  double getWeight(double weight) {
    if (weightUnit == WeightUnit.kg) {
      return weight;
    } else if (weightUnit == WeightUnit.lbs) {
      return weight * 2.2046;
    } else {
      return 0.0;
    }
  }
}
