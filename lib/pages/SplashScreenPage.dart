import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/HomePage.dart';
import 'package:flutterapp/pages/MapsTest.dart';
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MapSample())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 132, 50, 155),
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 132, 50, 155),
            image: DecorationImage(
              image: AssetImage('assets/images/StockholmStadLogga.png'),
            ),
          ),
        ),
      ),
    );
  }
}
