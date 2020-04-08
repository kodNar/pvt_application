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
      /*Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              "assets/images/bakgrund.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,),
          ),
        ],
      ),*/

      Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(
          color: Color.fromARGB(255,132, 50, 155),
          image: DecorationImage(
            image: AssetImage('assets/images/bakgrund.png'),
            fit: BoxFit.fill,
          ),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => LoginPage()));
            },
              child: const Text(
                'enabled button',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),





      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // lägger floating knappen i mitten.
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
          child: Icon(Icons.map)
      ),*/
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