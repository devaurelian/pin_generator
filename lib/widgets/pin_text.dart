// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A text widget that displays a PIN number, with opacity animation.
class PINText extends StatefulWidget {
  /// The current PIN to display.
  final int pin;

  PINText({Key key, @required this.pin}) : super(key: key);

  @override
  _PINTextState createState() => _PINTextState();
}

class _PINTextState extends State<PINText> {
  /// The current opacity of the PIN text.
  double _opacity = 1.0;

  /// The current PIN to display.
  int _pin = 0;

  /// Updates PIN with animation.
  Future<void> updatePIN() async {
    // Hide the old PIN
    setState(() {
      _opacity = 0.0;
    });

    // Wait half a second for the opacity animation to catch up
    await Future.delayed(const Duration(milliseconds: 500));

    // Update and show the new PIN
    setState(() {
      _pin = widget.pin;
      _opacity = 1.0;
    });
  }

  /// Update PIN with animation on [initState].
  @override
  void initState() {
    super.initState();
    updatePIN();
  }

  /// Update PIN with animation whenever the widget configuration changes.
  @override
  void didUpdateWidget(PINText oldWidget) {
    updatePIN();
    super.didUpdateWidget(oldWidget);
  }

  /// Describes the [PINText] widget user interface.
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _opacity,
      child: Text(
        _pin.toString(),
        style: _pin.toString().length <= 5
            ? Theme.of(context).textTheme.display4
            : Theme.of(context).textTheme.display3,
      ),
    );
  }
}
