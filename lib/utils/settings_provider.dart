import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider {

  static final String _pinDigitCountKey = 'pin_digit_count';
  static final String _backDigitCountKey = 'background_digit_count';

  static Future<void> setPinDigitCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pinDigitCountKey, value);
  }

  static Future<int> getPinDigitCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_pinDigitCountKey) ?? 4;
  }

  static Future<void> setBackDigitCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backDigitCountKey, value);
  }

  static Future<int> getBackDigitCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_backDigitCountKey) ?? 1000;
  }
}