import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';

import 'PrivateWorkoutPage.dart';

class RecentWorkouts extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<RecentWorkouts> {
  bool _loaded = false;
  List <WorkoutSession> selectedSessions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Recent Workouts",
        ),
        body: Column(
    children: <Widget>[_loaded
    ? Container(child: _listView())
        : Center(child: Text("Loading..."))
    ],
    ));
  }

  Widget _listView() {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: selectedSessions.length,
                itemBuilder: (context, index) {
                  return Column(children: <Widget>[
                    Container(
                        height: 70,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        color: Color(0xFF5D226D),

                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrivateWorkoutPage(
                                          selectedSessions[index].getExercises(),
                                          selectedSessions[index].name,selectedSessions[index])));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.perm_identity,color: Colors.white,),
                                              //Text(sessions[index].name),
                                              Text(selectedSessions[index].name, style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                          Text(selectedSessions[index]
                                              .getDateTime()
                                              .toString(), style: TextStyle(color: Colors.white)),
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.gps_fixed,color: Colors.white,),
                                            Text("Location", style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                        Text(selectedSessions[index].location, style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ]))),
                    Divider(
                      height:7,
                      color: Color.fromARGB(255, 132, 50, 155),
                    ),
                  ],);
                })));
  }

  Future<List<WorkoutSession>> _getSessions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<WorkoutSession> workouts =
    await DatabaseService(uid: user.uid).getUserWorkoutSessions();
    return workouts;
  }
  @override
  void initState() {
    super.initState();
    getList();
  }


  getList() async {
    List<WorkoutSession> old = await _getSessions();
    old.sort((a, b) {
      return -b.getDateTime().compareTo(a.getDateTime());
    });
    selectedSessions =old;
    setState(() {
      _loaded =true;
    });
  }

}
