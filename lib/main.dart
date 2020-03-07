import 'package:flutter/material.dart';
import 'package:pingenerator/screens/home.dart';

void main() => runApp(PINGeneratorApp());

class PINGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Generator',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(title: 'PIN Generator'),
    );
  }
}
