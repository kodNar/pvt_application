import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class ExistingWorkouts extends StatefulWidget {
  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<ExistingWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Existing Workouts",
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(40),
                child: FutureBuilder<WorkoutSession>(
                    future: _getSessions(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container(child: ListView.builder(
                      )
                      ) : Center(

                      );
                    })
            )));
    }

Future <WorkoutSession> _getSessions() async{

}
}