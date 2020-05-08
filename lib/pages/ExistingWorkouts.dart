import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';

class ExistingWorkouts extends StatefulWidget {
  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<ExistingWorkouts> {
  @override
  List<bool> _isSelected = [false, true];

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Discover Workouts",
        ),
        body: Column(
          children: <Widget>[
            Container(child: _topImage()),
            Container(child: _toggleSearch()),
            Container(
                // add search field
                ),
            Container(child: _listView()),
          ],
        ));
  }
  Widget _topImage() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 175,
      height: 75,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 132, 50, 155),
        image: DecorationImage(
          image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
        ),
      ),
    );
  }

  Widget _toggleSearch() {
    return ToggleButtons(
      fillColor: Colors.pink,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2 - 2,
          child: Text(
            "Most Recent",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          alignment: Alignment.center,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2 - 1,
          child: Text(
            "Highest Voted",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
      isSelected: _isSelected,
      onPressed: (int index) {
        setState(() {
          if (!_isSelected[index]) {
            _isSelected[index] = !_isSelected[index];
            if (index == 0) {
              _isSelected[1] = false;
            } else {
              _isSelected[0] = false;
            }
          }
        });
      },
    );
  }

  Widget _listView() {
    return FutureBuilder<List<WorkoutSession>>(
        future: _getSessions(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  child: Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                color: Color.fromARGB(
                                    255, 200 + index * 30, 50, 155),
                                child: InkWell(
                                    onTap: () {
                                      // länka till Session
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(snapshot.data[index].name),
                                          ),
                                          Container(child: Text(" Location: ")),

                                          Container(child: Text("Likes " + snapshot.data[index].likes.toString()),)


                                        ])));
                          })))
              : Center();
        });
  }

  Future<List<WorkoutSession>> _getSessions() async {
    List <WorkoutSession> list = [];
    QuerySnapshot workoutsCollection =
    await Firestore.instance.collection("Workouts").getDocuments();
    for (var doc in workoutsCollection.documents) {
      String name = doc.data['Name'];
      int likes = doc.data['Likes'];
      String location = doc.data['Location'];
      String user =doc.data['User'];
      DateTime date = (doc.data['Published']as Timestamp).toDate();
      list.add(WorkoutSession(name,user,location,date));
    }
    return list;
  }
}
