import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';
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
                child: FutureBuilder<List<String>>(
                    future: _getSessions(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          color: Color.fromARGB(
                                              255, 200+ index * 30, 50, 155),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(child: InkWell(
                                                splashColor: Colors.blue,
                                                highlightColor: Colors.purpleAccent,
                                                onTap: () {
                                                },
                                                child: RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  strutStyle: StrutStyle(
                                                      fontSize: 30.0),
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                      text: snapshot.data[index]
                                                  ),
                                                ),
                                              ),)
                                            ]));
                                  }))
                          : Center();
                    }))));
  }

  Future<List<String>> _getSessions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
      List<String> workouts =await DatabaseService(uid: user.uid).getWorkouts();
      return workouts;
  }
    }

