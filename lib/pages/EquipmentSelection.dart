import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';

class EquipmentSelection extends StatelessWidget {
  String _name;
  List<Equipment> _equipment = [];

  EquipmentSelection(String name, List<Equipment> equipment) {
    this._name = name;
    this._equipment = equipment;
  }


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
              height: 75,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white, width: 1.5),
                  ),
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_equipment[index].getName(),_equipment[index].exercises)));
                  },

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
  List<Exercise> _exercise =[];
  String post;

  DetailPage (String post, List<Exercise> ex) {
    this.post = post;
    this._exercise = ex;
  }
  @override
  _DetailPageState createState() => _DetailPageState(post,_exercise);
}

class _DetailPageState extends State<DetailPage> {
  List<Exercise> _exercise =[];
  String post;
  _DetailPageState (String post, List<Exercise> ex) {
    this.post = post;
    this._exercise = ex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        title: Text(widget.post),
      ),
      body: Container(
        child:ListView.builder(
            itemCount: _exercise.length,
          itemBuilder: (context,index) {
           return Container(child: Card(
              child: ListTile(
                title: Text(_exercise[index].name),
                subtitle: Text(_exercise[index].desc),
              ),
            ));
          }),
    ),
    );
    }
}





