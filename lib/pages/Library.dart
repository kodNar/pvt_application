import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:path/path.dart';

import '../OutdoorGym.dart';

class Library extends StatelessWidget {
  Map _map = Map<String, List<OutdoorGym>>();

  Library( Map map) {
    this._map = map;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: new AppBar(
        title: Text("Equipments"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_map.keys.elementAt(index), _map.values.elementAt(index))));
                  },
                  color: Color.fromARGB(255, 132, 50, 155),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(),
                                child: new Text(_map.keys.elementAt(index),
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
class DetailPage extends StatefulWidget {
  String post;
  List<OutdoorGym> list;

  DetailPage (String post, List<OutdoorGym> list) {
    this.post = post;
    this.list = list;
  }
  @override
  _DetailPageState createState() => _DetailPageState(post, list);
}

class _DetailPageState extends State<DetailPage> {
  String post;
  List<OutdoorGym> list;

  _DetailPageState (String post, List<OutdoorGym> list) {
    this.post = post;
    this.list = list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post),
      ),
      body: Container(
        child:ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index) {
              return Container(child: Card(
                child: ListTile(
                  title: Text(list[index].name),
                ),
              ));
            }),
      ),
    );
  }
}
