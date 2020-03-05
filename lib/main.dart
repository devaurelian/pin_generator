import 'package:flutter/material.dart';
import 'package:pingenerator/pages/home.dart';

void main() => runApp(PINGeneratorApp());

class PINGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Generator',
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'PIN Generator'),
    );
  }
}
