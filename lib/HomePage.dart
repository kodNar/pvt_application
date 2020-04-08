import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Login.dart';
import 'Settings.dart';
import 'workerData.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StalkerModel _stalkerModel = new StalkerModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 132, 50, 155),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                     MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ]),
      body: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 132, 50, 155),
          image: DecorationImage(

            image: AssetImage('assets/images/bakgrund.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ButtonTheme(
              minWidth: 150,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: BorderSide(color: Colors.green, width: 2.5),


                ),
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                       MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            ButtonTheme(
              minWidth: 150,
              height: 100,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.green, width: 2.5),
                ),
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: new Text(
                  'Guest',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 132, 50, 155),
        shape: CircularNotchedRectangle(),
        elevation: 0.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Stockholm Stad"),
            Padding(
              padding: const EdgeInsets.all(55.0),
            ),
          ],
        ),
      ),
    );
  }
}
