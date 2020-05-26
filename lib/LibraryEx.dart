import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/Library.dart';
import 'Equipment.dart';
import 'Exercise.dart';
import 'OutdoorGym.dart';

class LibraryEx extends StatelessWidget {
  Map _map = Map<String, List<OutdoorGym>>();

  LibraryEx( Map map) {
    this._map = map;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Library"),
      ),
      body: Builder(builder: (context) {
        return Stack(children: [
          Container(
            child: Column(children: <Widget>[
              Container(child:Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Library(_map)));
                            },

                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left: 65.0),
                                        child: new Text(
                                          "Equipment",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),

                                        ))
                                  ],
                                ))),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LibraryExPage()));
                            },

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 65.0),
                                      child: new Text(
                                        "Exercises",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            )),
                      ),
                    ]),
              ),
              ),

            ]),
          ),
        ]);
      }),
    );
  }

}

class LibraryExPage extends StatefulWidget {
  @override
  _LibraryExPageState createState() => _LibraryExPageState();
}

class _LibraryExPageState extends State<LibraryExPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Exercises"),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Exercise> exercises = [];
  int _selectedIndex = 0;
  String title = 'Equipment';

  Future _data;

  Future <List<Exercise>> getExercise() async {
    var temp = (await Firestore.instance.collection('Equipment').getDocuments());
    for (var doc in temp.documents) {
      String name = doc.documentID;
      var exerTemp = await Firestore.instance.collection('Equipment').document(name).collection("Exercises").getDocuments();
      for (var doc in exerTemp.documents) {
        Exercise e = Exercise(doc.data['Name'], doc.data['Desc']);
        if (e != null) {
          exercises.add(e);
        }
      }
    }
    print(exercises.length);
    return exercises;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 0) {
        title = 'Exercises';
      } else {
        title = 'Equipment';
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
  }
}






