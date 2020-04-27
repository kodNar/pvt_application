import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,//Value need no UID for this stream
      child: Scaffold(
      body: Form(
        child: Column(
          children: <Widget>[
          UserList()

          ],
        ),

      ),
      ),
    );
  }
}
