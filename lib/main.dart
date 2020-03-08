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
      ),
      home: HomeScreen(title: Strings.appName),
    );
  }
}
