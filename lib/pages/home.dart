import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingenerator/pages/settings.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/widgets/random_digits.dart';

enum OverflowMenuItem { settings, rate, help }

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final random = Random.secure();
  int _pin = 0;

  int _pinDigitCount = 4;
  int _backDigitCount = 1000;

  int next(int min, int max) => min + random.nextInt(max - min);

  void _refreshPIN() {
    setState(() {
//      _pin = random.nextInt(10000);
      _pin = next(pow(10, _pinDigitCount - 1), pow(10, _pinDigitCount));
    });
  }

  @override
  void initState() {
    super.initState();

    loadSettings();
  }

  Future<void> loadSettings() async {
    print('Home - loadSettings');

    int pinDigitCount = await SettingsProvider.getPinDigitCount();
    int backDigitCount = await SettingsProvider.getBackDigitCount();
    setState(() {
      _pinDigitCount = pinDigitCount;
      _backDigitCount = backDigitCount;
    });
    _refreshPIN();
  }

  void popupMenuSelection(OverflowMenuItem item) {
    switch (item) {
      case OverflowMenuItem.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        ).then((value) {
          loadSettings();
        });
        break;
      case OverflowMenuItem.rate:
        break;
      case OverflowMenuItem.help:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: 'Copy to clipboard',
            onPressed: () {},
          ),
          PopupMenuButton<OverflowMenuItem>(
            onSelected: popupMenuSelection,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: OverflowMenuItem.settings,
                child: Text('Settings'),
              ),
              PopupMenuItem(
                value: OverflowMenuItem.rate,
                child: Text('Rate app'),
              ),
              PopupMenuItem(
                value: OverflowMenuItem.help,
                child: Text('Help'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          RandomDigits(
            random: random,
            backDigitCount: _backDigitCount,
          ),
          Center(
            child: Text(
              _pin.toString(),
              style: Theme.of(context).textTheme.display4.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPIN,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
