import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/user_list.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/services/Database.dart';

class DatabaseTestPage extends StatefulWidget {
  @override
  _DatabaseTestPageState createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    /*Typ of data we get back a snapshot of the...*/
    return StreamProvider<List<User>>.value(
      value: DatabaseService().users, //Value need no UID for this stream
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Form(
          child: Column(
            children: <Widget>[
              UserList(),
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
                width: 200,
                height: 200,
                color: Colors.green,
                child: FlatButton(
                  onPressed: printNickname,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// Printar ut en användares nickname. Await var tydligen jävligt viktig annars
  /// blev det kaos

  printNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
     String nickname = await DatabaseService(uid: user.uid).getNickname();
    print(nickname);
  }
}
