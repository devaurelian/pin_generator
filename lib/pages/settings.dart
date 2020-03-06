import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _pinDigitCount = 4;
  double _backDigitCount = 1000;

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
              value: _pinDigitCount,
              label: _pinDigitCount.round().toString(),
              onChanged: (value) => setState(() {
                _pinDigitCount = value;
              }),
            ),
            SizedBox(height: 24),
            Text('Number of background digits'),
            Slider(
              min: 0,
              max: 1000,
              divisions: 1000,
              value: _backDigitCount,
              label: _backDigitCount.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _backDigitCount = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
