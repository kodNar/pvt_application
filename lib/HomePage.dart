import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Login.dart';
import 'package:flutterapp/MenuPage.dart';
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
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
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
        alignment: Alignment.center,
        /*decoration: BoxDecoration(
          color: Color.fromARGB(255, 132, 50, 155),
          image: DecorationImage(

            image: AssetImage('assets/images/AppLogga_vit.png'),
            fit: BoxFit.fill,
          ),
        ),*/
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 132, 50, 155),
                image: DecorationImage(

                  image: AssetImage('assets/images/applogga_vit_liten.png'),
                  fit: BoxFit.fill,
                ),
              ),

            ),

            ButtonTheme(
              minWidth: 150,
              height: 100,
              child: RaisedButton(
                //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
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
                  //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(color: Colors.green, width: 2.5),
                ),
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => MenuPage()));
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

        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("Stockholm Stad",
              style: TextStyle(color: Colors.white, fontFamily: 'Stockholm', fontStyle: FontStyle.italic , fontSize: 29.0),),
            Padding(
              padding: const EdgeInsets.all(55.0),
            ),
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
                      fit: BoxFit.fill)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
