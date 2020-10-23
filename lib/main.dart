import 'package:air_monitoring_cp/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Purifier CP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Air Purifier CP'),
          centerTitle: true,
        ),
        body: HomeScreen(),
      ),
    );
  }
}
