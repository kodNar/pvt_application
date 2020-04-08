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
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Settings()
                ));
              },
            ),
          ]
      ),



      body:
      Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.bottomCenter,
        decoration: new BoxDecoration(
          color: Color.fromARGB(255,132, 50, 155),
          image: DecorationImage(
            image: AssetImage('assets/images/bakgrund.png'),
            fit: BoxFit.fill,
          ),

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              color: Colors.transparent,
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => LoginPage()));
              },
              child: const Text('Sign in'),
              textColor: Colors.white,
            ),
            SizedBox(width: 10),
            RaisedButton(
              color: Colors.transparent,
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => LoginPage() ));
                },
              child: const Text('Guest'),
              textColor: Colors.white,

            )
          ],
        ),
      ),




     bottomNavigationBar: BottomAppBar(
       color:Color.fromARGB(255, 132, 50, 155),
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