import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';

import 'Login[DEAD].dart';
import '../WorkoutLog.dart';

class ExcerciseOrEquipment extends StatefulWidget {
  @override
  _ExcerciseOrEquipmentState createState() => _ExcerciseOrEquipmentState();
}

class _ExcerciseOrEquipmentState extends State<ExcerciseOrEquipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: BaseAppBar(
        title: 'Workout log',
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
                child: Text('Equipment',
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
                    MaterialPageRoute(builder: (context) => WorkoutLog()));
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
                child: Text('Exercise',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    )),
              ),
            ),
          ]),
        ),

      ),

    );
  }
}
