import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterapp/widgets/Appbar.dart';
import '../Equipment.dart';
import '../Exercise.dart';
import '../OutdoorGym.dart';

class LibraryEx extends StatefulWidget {
  final Map _map;

  LibraryEx(this._map);

  @override
  _LibraryExPageState createState() => _LibraryExPageState(_map);
}

class _LibraryExPageState extends State<LibraryEx> {
  List<Exercise> exercises = [];
  int _selectedIndex = 0;
  String title = 'Equipment';
  bool exercisePage = false;
  Future _data;
  Map _map = Map<String, List<OutdoorGym>>();

  _LibraryExPageState(Map map) {
    this._map = map;
  }

  //Hämtar alla exercises från databasen
  Future<List<Exercise>> getExercise() async {
    var temp =
    (await Firestore.instance.collection('Equipment').getDocuments());
    for (var doc in temp.documents) {
      String name = doc.documentID;
      var exerTemp = await Firestore.instance
          .collection('Equipment')
          .document(name)
          .collection("Exercises")
          .getDocuments();
      for (var doc in exerTemp.documents) {
        Exercise e = Exercise(doc.data['Name'], doc.data['Desc']);
        if (e != null) {
          exercises.add(e);
        }
      }
    }
    return exercises;
  }

  /*
  Används för att kalla på rätt Widget och titel när man byter mellan Equipment
  och Exercise
   */

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        title = 'Equipment';
        exercisePage = false;
      } else {
        title = 'Exercises';
        exercisePage = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _data = getExercise();
  }

  //Widget för nedre navigationsbar med knapp för Exercise och Equipment
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '$title',
      ),
      backgroundColor: Color(0xFF84329b),
      body: Center(
        child: exerciseList(),
        //child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Equipment'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            title: Text('Exercises'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF84329b),
        onTap: _onItemTapped,
      ),
    );
  }

  /*
  Visar antingen en sida med alla exercises eller alla equipment
   */
  Widget exerciseList() {
    if (exercisePage) {
      return new Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              width: 200,
              height: 55,
              child: Text(
                'Here is a list of all Exercises',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading... "),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: exercises.length,
                          itemBuilder: (_, index) {
                            return Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.transparent,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 100,

                              child: RaisedButton(
                                  shape:  RoundedRectangleBorder(
                                    borderRadius:
                                     BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                  color: Color.fromARGB(255, 132, 50, 155),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(),
                                                child: new Text(
                                                    exercises[index].getName(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold))),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.play_circle_outline),
                                              iconSize: 50,
                                              alignment: Alignment.centerRight,
                                              onPressed: () {
                                              },
                                            )
                                          ]))),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      );
    } else {
      return new Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 250,
            height: 55,
            child: Text(
              'Here is a list of all available equipment around Stockholm ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _map.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.transparent,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 100,
                    child: RaisedButton(
                        shape:  RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(
                                          _map.keys.elementAt(index),
                                          _map.values.elementAt(index))));
                        },
                        color: Colors.transparent,
                        child: Align(
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(),
                                      child:  Text(
                                          _map.keys.elementAt(index),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)))
                                ]))),
                  );
                }),
          ),
        ]),
      );
    }
  }
}

class DetailPage extends StatefulWidget {
  String post;
  List<OutdoorGym> list;

  DetailPage(String post, List<OutdoorGym> list) {
    this.post = post;
    this.list = list;
  }

  @override
  _DetailPageState createState() => _DetailPageState(post, list);
}

class _DetailPageState extends State<DetailPage> {
  String post;
  List<OutdoorGym> list;

  _DetailPageState(String post, List<OutdoorGym> list) {
    this.post = post;
    this.list = list;
  }

  // Visar alla gym som har den tidigare valda equipmentet
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        title: Text(widget.post),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5),
            width:  500,
            height: 65,
            child: Text('Here are all the gyms with that specific equipment',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Card(
                        child: ListTile(
                          title: Text(list[index].name),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
