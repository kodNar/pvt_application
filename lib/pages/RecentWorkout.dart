import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';

class RecentWorkouts extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<RecentWorkouts> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Recent Workouts",
        ),
        body: Center(child: Container(child: _listView())));
  }

  Widget _listView() {
    return FutureBuilder<List<WorkoutSession>>(
        future: _getList(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            color:
                                Color.fromARGB(255, 200 + index * 30, 50, 155),
                            child: InkWell(
                                onTap: () {
                                  // länka till Session
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(snapshot.data[index].name),
                                      ),
                                      Container(
                                          child: Text(" Location: " +
                                              snapshot.data[index].location)),
                                      Container(child: Text("Likes "))
                                    ])));
                      }))
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Future<List<WorkoutSession>> _getSessions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<WorkoutSession> workouts =
    await DatabaseService(uid: user.uid).getUserWorkoutSessions();
    return workouts;
  }

  Future<List<WorkoutSession>> _getList() async {
    List<WorkoutSession> old = await _getSessions();
    old.sort((a, b) {
      return -b.getDateTime().compareTo(a.getDateTime());
    });
    return old;
  }
}
