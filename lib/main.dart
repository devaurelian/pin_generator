import 'package:flutter/material.dart';
import 'package:pingenerator/screens/home.dart';

void main() => runApp(PINGeneratorApp());

class PINGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
//        accentColor: Colors.redAccent,

        textTheme: TextTheme(
          display4: Theme.of(context).textTheme.display4.copyWith(
//            color: Colors.red,
            fontWeight: FontWeight.w900,
          ),
          display3: Theme.of(context).textTheme.display3.copyWith(
            fontWeight: FontWeight.w900,
          ),
        )
      ),
      home: HomeScreen(title: 'PIN Generator'),
    );
  }
}
