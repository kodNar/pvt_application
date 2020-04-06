import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'workerData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(title: 'Outside Gains'),
    );
  }
}
