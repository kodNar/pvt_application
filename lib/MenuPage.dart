import 'package:flutter/material.dart';
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
                padding: EdgeInsets.all(20),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 50, 155),
                  image: DecorationImage(
                    image: AssetImage('assets/images/bakgrund.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(children: [
                  Container(),
                  Container(),
                  Container(),
                ]))));
  }
}
