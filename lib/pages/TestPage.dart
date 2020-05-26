import 'package:flutter/material.dart';

import 'package:flutterapp/pages/ExistingWorkouts.dart';
import 'package:flutterapp/pages/FAQ.dart';
import 'package:flutterapp/pages/JohanTest.dart';
import 'package:flutterapp/services/DatabaseTestPage.dart';

import 'JacobTest.dart';
import 'package:flutterapp/pages/AboutGymsPage.dart';

import 'JacobTest.dart';
import 'JacobTest.dart';
import 'JacobTest.dart';
import 'MapsTest.dart';
import 'package:flutterapp/pages/ReportPage.dart';

import 'OnBoardPage.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF84329b),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseTestPage()));
                },
                child: Text(
                  'Einar testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(

              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                   /** Sätt din testsida här! **/
                },
                child: Text(
                  'Martins testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(

              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardPage())); /** Sätt din testsida här! **/
                },
                child: Text(
                  'Simons testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(

              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage() )); /** Sätt din testsida här! **/
                },
                child: Text(
                  'Claes testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0,10,0,10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => testis() )); /** Sätt din testsida här! **/
                },
                child: Text(
                  'Jacobs testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExistingWorkouts()));
                },
                child: Text(
                  'Johan testknapp',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
