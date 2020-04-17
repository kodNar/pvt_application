import 'package:flutter/material.dart';
class GenericGymPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Settings'),
            actions: <Widget>[]),
        body: Builder(
          builder: (context) {
            return Stack(children: [
              Container(child: ListView(children: <Widget>[
                Container(

                )
              ])),
            ]);
          },
        ));
  }
}
