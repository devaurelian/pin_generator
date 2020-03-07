import 'package:flutter/material.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/utils/strings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _pinDigitCount = SettingsProvider.pinDigitCountDefault;
  int _backDigitCount = SettingsProvider.backDigitCountDefault;

  @override
  void initState() {
    super.initState();

    loadSettings();
  }

  Future<void> loadSettings() async {
    int pinDigitCount = await SettingsProvider.getPinDigitCount();
    int backDigitCount = await SettingsProvider.getBackDigitCount();
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
              divisions: SettingsProvider.pinDigitCountMax,
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
              divisions: SettingsProvider.backDigitCountMax,
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
