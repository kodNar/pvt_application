import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';

class Library extends StatelessWidget {
  List<Equipment> _equipment = [];
  Map _map;

  Library(Map map) {
    this._map = map;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: new AppBar(
        title: Text("hej"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _map.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8),
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                  },
                  color: Color.fromARGB(255, 132, 50, 155),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(),
                                child: new Text(_map[index].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)))
                          ]))),
            );
          }),
    );
  }
}
