import 'package:flutter/material.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'Settings.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'Menu',
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 132, 50, 155),
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text('Menu'),
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
                color: Color.fromARGB(255, 132, 50, 155),
                padding: EdgeInsets.only(top: 20),
                width: size.width,
                height: size.height,
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Appnamn",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Stockholm',
                          fontStyle: FontStyle.italic,
                          fontSize: 45
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 132, 50, 155),
                          image: DecorationImage(
                            image: AssetImage('assets/images/AppLogga_vit.png'),
                            fit: BoxFit.fill,
                      ),
                    ),
                  ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 125,
                              height: 75,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.white, width: 2.5),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyApp()
                                    )
                                  );
                                },
                                child: Text(
                                  'Nav',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),

                                ),
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 125,
                              height: 75,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.white, width: 2.5),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuPage()
                                      )
                                  );
                                },
                                child: Text(
                                  'Nav',
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
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 125,
                              height: 75,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.white, width: 2.5),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuPage()
                                      )
                                  );
                                },
                                child: Text(
                                  'Nav',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),

                                ),
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 125,
                              height: 75,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.white, width: 2.5),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuPage()
                                      )
                                  );
                                },
                                child: Text(
                                  'Nav',
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
                ]))));
  }
}
