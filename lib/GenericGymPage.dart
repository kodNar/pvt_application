import 'package:flutter/material.dart';
class GenericGymPage extends StatelessWidget {
  String _name;
  List <String> _equipment = [];


  GenericGymPage(String name, List<String> Equipment) {

  }
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
