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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Recent Workouts",
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                child: FutureBuilder<List<WorkoutSession>>(
                    future: _getList(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {

                                    return Container(
                                        alignment: Alignment.center,
                                        height: 80,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Color.fromARGB(
                                              255, 200 + index * 30, 50, 155),
                                        ),
                                        child: InkWell(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                              Container(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  strutStyle: StrutStyle(
                                                      fontSize: 22.0),
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      text: snapshot
                                                          .data[index].name),
                                                ),
                                              ),
                                              Container(child: Text("Time: " +snapshot.data[index].getDateTime().toString().substring(0,16))),
                                            Container(child:Text("Location: " ))
                                                ])));
                                  }))
                          : Center();
                    }))));
  }

  Future<List<WorkoutSession>> _getSessions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<WorkoutSession> workouts =
        await DatabaseService(uid: user.uid).getWorkouts();
    return workouts;
  }
  Future <List<WorkoutSession>> _getList() async{
    List <WorkoutSession> old = await _getSessions();
    old.sort((a,b){
    return -b.getDateTime().compareTo(a.getDateTime());
  });
    return old;
  }

}
