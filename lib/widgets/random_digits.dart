// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

/// A widget that displays random digits at random positions.
class RandomDigits extends StatelessWidget {
  /// The default number of digits.
  static const int defaultDigitCount = 100;

  /// The number of random digits to display.
  final int digitCount;

  /// The random number generator for digits and their positions.
  final Random random;

  /// Creates a [RandomDigits] widget.
  const RandomDigits(
      {Key key, @required this.random, this.digitCount = defaultDigitCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var i = 0; i < this.digitCount; i++)
          AnimatedPositioned(
            top: random
                .nextInt(MediaQuery.of(context).size.height.toInt())
                .toDouble(),
            left: random
                .nextInt(MediaQuery.of(context).size.width.toInt())
                .toDouble(),
            child: Text(
              random.nextInt(10).toString(),
            ),
            duration: Duration(seconds: 1),
          ),
      ],
    );
  }
}
