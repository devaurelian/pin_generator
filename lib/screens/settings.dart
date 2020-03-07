// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/utils/strings.dart';

/// The Settings screen widget that lets the user change app settings.
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// The current PIN digit count setting value.
  int _pinDigitCount = SettingsProvider.pinDigitCountDefault;

  /// The current background digit count setting value.
  int _backDigitCount = SettingsProvider.backDigitCountDefault;

  /// Load settings on [initState].
  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  /// Loads the app settings from persistent storage.
  Future<void> loadSettings() async {
    final int pinDigitCount = await SettingsProvider.getPinDigitCount();
    final int backDigitCount = await SettingsProvider.getBackDigitCount();
    setState(() {
      _pinDigitCount = pinDigitCount;
      _backDigitCount = backDigitCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.settingsTitle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(Strings.pinDigitCountSetting),
            Slider(
              min: SettingsProvider.pinDigitCountMin.toDouble(),
              max: SettingsProvider.pinDigitCountMax.toDouble(),
              divisions: SettingsProvider.pinDigitCountMax -
                  SettingsProvider.pinDigitCountMin,
              value: _pinDigitCount.toDouble(),
              label: _pinDigitCount.toString(),
              onChanged: (value) => setState(() {
                _pinDigitCount = value.round();
                SettingsProvider.setPinDigitCount(_pinDigitCount);
              }),
            ),
            SizedBox(height: 24),
            Text(Strings.backDigitCountSetting),
            Slider(
              min: SettingsProvider.backDigitCountMin.toDouble(),
              max: SettingsProvider.backDigitCountMax.toDouble(),
              divisions: SettingsProvider.backDigitCountMax -
                  SettingsProvider.backDigitCountMin,
              value: _backDigitCount.toDouble(),
              label: _backDigitCount.toString(),
              onChanged: (double value) {
                setState(() {
                  _backDigitCount = value.round();
                  SettingsProvider.setBackDigitCount(_backDigitCount);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
