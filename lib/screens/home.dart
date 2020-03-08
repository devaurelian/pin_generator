// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingenerator/screens/settings.dart';
import 'package:pingenerator/utils/settings_provider.dart';
import 'package:pingenerator/utils/utils.dart';
import 'package:pingenerator/widgets/pin_text.dart';
import 'package:pingenerator/widgets/random_digits.dart';
import 'package:pingenerator/utils/strings.dart';
import 'package:share/share.dart';

/// Overflow menu items enumeration.
enum OverflowMenuItem { settings, rate, help }

/// The Home screen widget.
class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The random number generator.
  ///
  /// By default create a pseudo-random generator, which does not throw errors.
  Random _randomGenerator = Random();

  /// The current generated PIN.
  int _pin = 0;

  /// The PIN digit count.
  int _pinDigitCount = SettingsProvider.pinDigitCountDefault;

  /// The background digit count.
  int _backDigitCount = SettingsProvider.backDigitCountDefault;

  /// Whether to use a secure random number generator.
  bool _useSecureRandom = SettingsProvider.useSecureRandomDefault;

  /// The AppBar's action needs this key to find its own Scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Load settings and refresh PIN and digits on [initState].
  @override
  void initState() {
    super.initState();
    loadSettingsAndRefresh();
  }

  /// Loads the app settings from persistent storage and generate a new PIN and
  /// random digits based on the loaded settings.
  Future<void> loadSettingsAndRefresh() async {
    _pinDigitCount = await SettingsProvider.getPinDigitCount();
    _backDigitCount = await SettingsProvider.getBackDigitCount();
    _useSecureRandom = await SettingsProvider.getUseSecureRandom();

    // Create the random number generator
    _randomGenerator = RandomX.create(secure: _useSecureRandom);

    // Generate a new PIN
    _refreshPIN();
  }

  /// Generates and displays a new PIN.
  ///
  /// Called on startup and when the user taps the floating action button.
  Future<void> _refreshPIN() async {
    setState(() {
      _pin = _randomGenerator.nextIntOfDigits(_pinDigitCount);
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
        // Navigate to the Settings screen, and load settings and refresh on return
        loadSettingsScreen();
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

  /// Navigates to the Settings screen, and loads settings and refreshes on return.
  Future<void> loadSettingsScreen() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    loadSettingsAndRefresh();
  }

  /// Describes the main ([Scaffold]) part of the app user interface.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: _randomGenerator.isSecure
            ? Tooltip(
                message: Strings.secureRandomTooltip,
                child: const Icon(Icons.enhanced_encryption),
              )
            : null,
//        titleSpacing: 0.0,
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
            random: _randomGenerator,
            digitCount: _backDigitCount,
          ),
          Center(
            child: PINText(
              pin: _pin,
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
