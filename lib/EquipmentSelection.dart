import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Equipment.dart';

class EquipmentSelection extends StatelessWidget {
  String _name;
  List<Equipment> _equipment = [];

  EquipmentSelection(String name, List<Equipment> equipment) {
    this._name = name;
    this._equipment = equipment;
  }

  /*
  TODO måste hämta equipment när man väl valt gymmet, för att sedan hämta alla övningar som finns på respektive equipment
   */

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: new AppBar(
        title: Text(_name),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _equipment.length,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_equipment[index].getName())));
                  },
                  color: Color.fromARGB(255, 132, 50, 155),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(),
                                child: new Text(_equipment[index].getName(),
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

  DetailPage (String post) {
    this.post = post;
  }
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text("Övning"),
            subtitle: Text("Beskrivning???"),
          ),
        ),
      ),
    );
  }
}


