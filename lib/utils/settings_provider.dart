// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';

/// Helper class that saves and reads app settings to persistent storage.
class SettingsProvider {
  /// The min, max and default values for the PIN digit count setting.
  static const int pinDigitCountMin = 1;
  static const int pinDigitCountMax = 9;
  static const int pinDigitCountDefault = 4;

  /// The min, max and default values for the background digit count setting.
  static const int backDigitCountMin = 0;
  static const int backDigitCountMax = 1000;
  static const int backDigitCountDefault = 1000;

  /// Persistent storage keys.
  static final String _pinDigitCountKey = 'pin_digit_count';
  static final String _backDigitCountKey = 'background_digit_count';

  /// Saves the PIN digit count setting [value] to persistent storage.
  static Future<void> setPinDigitCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pinDigitCountKey, value);
  }

  /// Reads the PIN digit count setting value from persistent storage.
  ///
  /// Ensures a default value, and clamps the value if required.
  static Future<int> getPinDigitCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_pinDigitCountKey) ?? pinDigitCountDefault)
        .clamp(pinDigitCountMin, pinDigitCountMax);
  }

  /// Saves the background digit count setting [value] to persistent storage.
  static Future<void> setBackDigitCount(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backDigitCountKey, value);
  }

  /// Reads the background digit count setting value from persistent storage.
  ///
  /// Ensures a default value, and clamps the value if required.
  static Future<int> getBackDigitCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_backDigitCountKey) ?? backDigitCountDefault)
        .clamp(backDigitCountMin, backDigitCountMax);
  }
}
