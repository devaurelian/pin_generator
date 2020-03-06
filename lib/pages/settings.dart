import 'package:flutter/material.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _pinDigitCount = 4;
  int _backDigitCount = 1000;

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
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Number of PIN digits'),
            Slider(
              min: 1,
              max: 10,
              divisions: 10,
              value: _pinDigitCount.toDouble(),
              label: _pinDigitCount.toString(),
              onChanged: (value) => setState(() {
                _pinDigitCount = value.round();
                SettingsProvider.setPinDigitCount(_pinDigitCount);
              }),
            ),
            SizedBox(height: 24),
            Text('Number of background digits'),
            Slider(
              min: 0,
              max: 1000,
              divisions: 1000,
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
