import 'package:flutter/material.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';

import 'MapsTest.dart';

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Center(
            child: Text(
              'Workout log',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => WorkoutPortal()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 40,
            semanticLabel: 'Back',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 40,
              color: Colors.black,
            ),
            tooltip: 'Go to homepage',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapSample()));
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Form(
        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {},
                child: Text(
                  "Flat Button",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
