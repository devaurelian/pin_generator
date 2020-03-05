import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingenerator/widgets/random_digits.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final random = Random.secure();
  int _pin = 0;

  void _refreshPIN() {
    setState(() {
      _pin = random.nextInt(10000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: 'Copy to clipboard',
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Settings'),
              ),
              PopupMenuItem(
                child: Text('Rate app'),
              ),
              PopupMenuItem(
                child: Text('Help'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          RandomDigits(
            random: random,
          ),
          Center(
            child: Text(
              _pin.toString(),
              style: Theme.of(context).textTheme.display4.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPIN,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
