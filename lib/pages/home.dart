import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingenerator/pages/settings.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/utils/utils.dart';
import 'package:pingenerator/widgets/random_digits.dart';
import 'package:pingenerator/utils/strings.dart';

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

  /// The AppBar's action needs this key to find its own Scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Generates and displays a new PIN.
  ///
  /// Called on startup and when the user taps the _Refresh_ floating action button.
  void _refreshPIN() {
    setState(() {
      _pin = random.nextIntOfDigits(_pinDigitCount);
    });

//    final StringBuffer buffer = StringBuffer();
//    for (var i = 0; i < 1000; i++) {
//      print(random.nextIntOfDigits(_pinDigitCount));
////      buffer.write('${random.randomIntOfDigits(_pinDigitCount)}, ');
//    }
//    print(buffer.toString());
  }

  /// Copies the current PIN to the clipboard.
  ///
  /// Called when the user taps the _Copy_ action button.
  void _copyPIN() {
    copyToClipboard(_scaffoldKey.currentState, _pin.toString());
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: Strings.copyTooltip,
            onPressed: _copyPIN,
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
        tooltip: Strings.refreshTooltip,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
