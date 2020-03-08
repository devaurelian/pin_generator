// Copyright 2020 anaurelian. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pingenerator/screens/home.dart';
import 'package:pingenerator/utils/strings.dart';

void main() => runApp(PINGeneratorApp());

/// The main app widget.
class PINGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.redAccent,
        textTheme: TextTheme(
          display4: Theme.of(context).textTheme.display4.copyWith(
                fontWeight: FontWeight.w900,
              ),
          display3: Theme.of(context).textTheme.display3.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
      home: HomeScreen(title: Strings.appName),
    );
  }
}
