import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingenerator/pages/settings_screen.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/utils/utils.dart';
import 'package:pingenerator/widgets/random_digits.dart';
import 'package:pingenerator/utils/strings.dart';
import 'package:share/share.dart';

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

  /// Generates and displays a new PIN.
  ///
  /// Called on startup and when the user taps the floating action button.
  void _refreshPIN() {
    setState(() {
      _pin = random.nextIntOfDigits(_pinDigitCount);
    });
  }

  /// Shares the current PIN.
  ///
  /// Called when the user taps the _Share_ action button.
  void _sharePIN() {
    Share.share(_pin.toString(), subject: Strings.shareSubject);
  }

  /// Copies the current PIN to the clipboard.
  ///
  /// Called when the user taps the _Copy_ action button.
  void _copyPIN() {
    copyToClipboard(_scaffoldKey.currentState, _pin.toString());
  }

  /// Performs the tasks of the overflow menu items.
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
        // Launch the Google Play Store page to allow the user to rate the app
        launchUrl(_scaffoldKey.currentState, Strings.rateAppURL);
        break;
      case OverflowMenuItem.help:
        // Launch the app online help url
        launchUrl(_scaffoldKey.currentState, Strings.helpURL);
        break;
    }
  }

  /// Describes the main ([Scaffold]) part of the app user interface.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: Strings.shareTooltip,
            onPressed: _sharePIN,
          ),
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
                child: Text(Strings.settingsMenuItem),
              ),
              PopupMenuItem(
                value: OverflowMenuItem.rate,
                child: Text(Strings.rateAppMenuItem),
              ),
              PopupMenuItem(
                value: OverflowMenuItem.help,
                child: Text(Strings.helpMenuItem),
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
