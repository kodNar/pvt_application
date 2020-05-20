import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/ExistingWorkouts.dart';
import 'package:flutterapp/pages/dead%20pages/Login%5BDEAD%5D.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/pages/RecentWorkout.dart';
import 'package:flutterapp/pages/WorkoutLog.dart';
import 'package:flutterapp/widgets/Appbar.dart';
class WorkoutPortal extends StatefulWidget {
  @override
  _WorkoutPortalState createState() => _WorkoutPortalState();
}

class _WorkoutPortalState extends State<WorkoutPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(right: 50),
            child: Center(
              child: Text(
                'Workouts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapSample()));
            },
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
              semanticLabel: 'Home button',
            ),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkoutLog()));
                },
                child: Container(
                  width: 350,
                  height: 135,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  child: Text('+ Log new workout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      )),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExistingWorkouts()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 135,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      colors: <Color>[
                        Color(0xFFF57C00),
                        Color(0xFFFF9800),
                        Color(0xFFFFA726),
                      ],
                    ),
                  ),
                  child: Text('+ Discover workouts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      )),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecentWorkouts()));
                },
                child: Container(
                  width: 350,
                  height: 135,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF388E3C),
                        Color(0xFF4CAF50),
                        Color(0xFF81C784),
                      ],
                    ),
                  ),
                  child: Text('My workouts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      )),
                ),
              ),
            ]),
          ),
        ));
  }
}
