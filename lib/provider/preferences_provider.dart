import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preference/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  bool _isDailyActive = false;
  bool get isDailyActive => _isDailyActive;
  PreferencesHelper preferencesHelper;

  PreferenceProvider({required this.preferencesHelper}) {
    _getDailyNewsPreferences();
  }

  void _getDailyNewsPreferences() async {
    _isDailyActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurantActive(value);
    _getDailyNewsPreferences();
  }
}
