import 'dart:math';

import 'package:flutter/material.dart';

class RandomDigits extends StatelessWidget {
  final Random random;
  final int backDigitCount;

  const RandomDigits({Key key, @required this.random, this.backDigitCount})
      : assert(random != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var i = 0; i < this.backDigitCount; i++)
          AnimatedPositioned(
            top: random
                .nextInt(MediaQuery.of(context).size.height.toInt())
                .toDouble(),
            left: random
                .nextInt(MediaQuery.of(context).size.width.toInt())
                .toDouble(),
            child: Text(
              random.nextInt(10).toString(),
//                style: TextStyle(backgroundColor: Colors.blue),

//              style: Theme.of(context).textTheme.body1.copyWith(
//                    color: Colors.grey[900],
//                  ),
            ),
            duration: Duration(seconds: 1),
          ),
      ],
    );
  }
}
