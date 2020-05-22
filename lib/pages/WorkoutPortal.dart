import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/ExistingWorkouts.dart';
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
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: 'Workouts',
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExistingWorkouts()));
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
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[

                        Color(0xFF84329b),
                        Color(0xFF84329b),
                        Color(0xFF9438ae),
                        Color(0xFFa53fc1),

                     //   Color(0xFFB388FF),
                      ],
                    ),
                  ),
                  child: Text('+ Log new workout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(

                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,

                      colors: <Color>[
                        Color(0xFF6200EA),
                        Color(0xFF651FFF),
                        Color(0xFF7C4DFF),
                        Color(0xFFB388FF),

                        /*
                        Color(0xFF5E35B1),
                        Color(0xFF673AB7),
                        Color(0xFF7E57C2),
                        Color(0xFF9575CD),

                         */
                        /*
                        Color(0xFF6A1B9A),
                        Color(0xFF7B1FA2),
                        Color(0xFF8E24AA),
                        Color(0xFF9C27B0),
                        Color(0xFFAB47BC),
                        Color(0xFFBA68C8),
                        */

                      ],
                    ),
                  ),
                  child: Text('Discover workouts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,

                      colors: <Color>[

                        Color(0xFF6200EA),
                        Color(0xFF651FFF),
                        Color(0xFF7C4DFF),
                        Color(0xFFB388FF),

                        /*
                        Color(0xFF5E35B1),
                        Color(0xFF673AB7),
                        Color(0xFF7E57C2),
                        Color(0xFF9575CD),

                         */
                        /*
                        Color(0xFF6A1B9A),
                        Color(0xFF7B1FA2),
                        Color(0xFF8E24AA),
                        Color(0xFF9C27B0),
                        Color(0xFFAB47BC),
                        Color(0xFFBA68C8),
                        */

                      ],
                    ),
                  ),
                  child: Text('My workouts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      )),
                ),
              ),
            ]),
          ),
        ));
  }
}
