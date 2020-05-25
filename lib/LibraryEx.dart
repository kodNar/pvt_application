import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Equipment.dart';
import 'Exercise.dart';

class LibraryEx extends StatelessWidget {


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

  Future _data;

  Future <List<Exercise>> getExercise() async {
    var exerTemp = await Firestore.instance.collection('Equipment').getDocuments();
    for (var doc in exerTemp.documents) {

    }
    //QuerySnapshot qn = await firestore.collection("Equipment").getDocuments();
    for (var doc in exerTemp.documents) {
      Exercise e = Exercise(doc.data['Name'], doc.data['Desc']);
      if (e != null) {
        exercises.add(e);
      }
    }


    return exercises;
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
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      /*
                      Namnet på fältet du hämtar. Ska även ha en string med sig
                      så rätt fält hämtas beroende på vad du vill utföra
                       */
                      title: Text(snapshot.data[index].data["Name"]),
                    );
                  });
            }
          }),
    );
  }
}






