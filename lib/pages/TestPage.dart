import 'package:flutter/material.dart';
import 'package:flutterapp/services/DatabaseTestPage.dart';

import 'JacobTest.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseTestPage() )); /** Sätt din testsida här! **/
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseTestPage() )); /** Sätt din testsida här! **/
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseTestPage() )); /** Sätt din testsida här! **/
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapSampleJacobo() )); /** Sätt din testsida här! **/
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
          ],
        ),
      ),
    );
  }
}
