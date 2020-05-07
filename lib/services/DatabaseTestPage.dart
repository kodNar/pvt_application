import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/services/user_list.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/Database.dart';

class DatabaseTestPage extends StatefulWidget {
  @override
  _DatabaseTestPageState createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  @override
  Widget build(BuildContext context) {
    /*Typ of data we get back a snapshot of the...*/
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Form(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: FlatButton(
                  child: null,
                  onPressed: printNickname,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: FlatButton(
                  child: null,
                  onPressed: updateNickname,
                ),
              ),

              Container(
                width: 100,
                height: 100,
                color: Colors.purple,
                child: FlatButton(
                  onPressed: () async{
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    DatabaseService(uid: user.uid).getWorkouts();
                  }, child: null,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: FlatButton(
                  onPressed: () async{
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    DatabaseService(uid: user.uid).addWorkout('batman');
                  },child: null,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.teal,
                child: FlatButton(
                  onPressed: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
                  },child: null,
                ),
              ),
            ],
          ),
        ),
    );
  }

  /// Printar ut en användares nickname. Await var tydligen jävligt viktig annars
  /// blev det kaos

  updateNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid)
        .updateUserData(user.uid, user.email, 'Batman');
  }

  printNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String nickname = await DatabaseService(uid: user.uid).getNickname();
    print(nickname);
    print(user.uid);
  }
}
