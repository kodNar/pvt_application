import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/Library(DEAD).dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'Equipment.dart';
import 'Exercise.dart';
import 'OutdoorGym.dart';

class LibraryEx extends StatefulWidget {
  final Map _map;

  LibraryEx(this._map);

  @override
  _LibraryExPageState createState() =>
      _LibraryExPageState(_map);


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

  //Hämtar från databasen
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

  Widget exerciseList() {
    if (exercisePage) {
      return Container(
        child: FutureBuilder(
            future: _data,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading... "),
                );
              } else {
                return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        /*
                      Namnet på fältet du hämtar. Ska även ha en string med sig
                      så rätt fält hämtas beroende på vad du vill utföra
                       */
                        title: Text(exercises[index].getName()),
                      );
                    });
              }
            }),
      );
    } else {
      return new Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
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
