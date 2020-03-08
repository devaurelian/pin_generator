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

//    List<double> fontSizes = new List(9);
//    fontSizes.fillRange(0, 4, 112.0);
//    fontSizes.fillRange(4, 5, 96.0);
//    fontSizes.fillRange(5, 9, 60.0);
//    List<double> fontSizes = [192.0, 144.0, 112.0, 112.0, 96.0, 60.0, 60.0, 60.0, 60.0];
//    List<double> fontSizes = [192.0, 144.0, 128.0, 120.0, 96.0, 60.0, 60.0, 60.0, 60.0];
    List<double> fontSizes = [192.0, 144.0, 128.0, 120.0, 96.0, 72.0, 64.0, 60.0, 48.0];
    print(fontSizes);
    print(fontSizes[_pin.toString().length - 1]);

    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _opacity,
      child: Text(
        _pin.toString(),
//        style: _pin.toString().length <= 5
//            ? Theme.of(context).textTheme.display4
//            : Theme.of(context).textTheme.display3,
        style: Theme.of(context).textTheme.display4.copyWith(
//          fontSize: MediaQuery.of(context).size.width / _pin.toString().length,
//          fontSize: MediaQuery.of(context).size.shortestSide / _pin.toString().length.clamp(2, 6),
          fontSize: fontSizes[_pin.toString().length - 1],
//          fontSize: _pin.toString().length <= 4 ? 112.0 : 60.0,
        )

      ),
    );
  }
}
