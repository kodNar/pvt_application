import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/pages/PublicWorkoutsSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';
import 'FavoritWorkoutPage.dart';

class FavoritWorkouts extends StatefulWidget {
  @override
  _FavoritState  createState() => _FavoritState ();
}

class _FavoritState extends State<FavoritWorkouts> {
  @override
  List<WorkoutSession> sessions = [];
  List<WorkoutSession> selectedSessions = [];
  List<String> allGymNames = List<String>();
  List<String> queriedGymNames = List<String>();
  bool _loaded = false;
  String searchGym = "";

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Favorit workouts",
        ),
        body: Column(
          children: <Widget>[
            Container(child: _searchField()),
            _loaded
                ? Container(child: _listView())
                : Center(child: Text("Loading..."))
            //prova !_loaded så kanske den laddar direkt sen
          ],
        ));
  }
  Widget _searchField() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          prefixIcon: Icon(Icons.search),
          hintText: "Search for a gym",
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.white,
        onChanged: (value) {
          selectedList(value);
        },
        //onSaved: (input) => input = searchGym,
      ),
    );
  }
  Widget _listView() {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: selectedSessions.length,
                itemBuilder: (context, index) {
                  return Column(children: <Widget>[
                    Container(
                        height: 70,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        color: Color(0xFF5D226D),

                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoritWorkoutPage(
                                          selectedSessions[index].getExercises(),
                                          selectedSessions[index].name,selectedSessions[index])));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.perm_identity,color: Colors.white,),
                                              //Text(sessions[index].name),
                                              Text(selectedSessions[index].name, style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                          Text(selectedSessions[index]
                                              .getDateTime()
                                              .toString().substring(0,10), style: TextStyle(color: Colors.white)),
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.gps_fixed,color: Colors.white,),
                                            Text("Location", style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                        Text(selectedSessions[index].location, style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.thumb_up,
                                            color: Colors.white,
                                          ),
                                          //Text(sessions[index].likes.toString()),
                                          Text(selectedSessions[index]
                                              .likes
                                              .toString(), style: TextStyle(color: Colors.white)),
                                        ],
                                      ))
                                ]))),
                    Divider(
                      height:7,
                      color: Color.fromARGB(255, 132, 50, 155),
                    ),
                  ],);
                })));
  }

  _getSessions() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    selectedSessions = await DatabaseService(uid: user.uid).getFavoritedWorkouts();
    sessions =selectedSessions;
  }

  void searchFilter(String query) {
    List<String> tempSearchList = List<String>();
    tempSearchList.addAll(allGymNames);
    print('Tempsearch list: $tempSearchList'.length);
    if (query.isNotEmpty) {
      List<String> tempListData = List<String>();
      tempSearchList.forEach((item) {
        if (item.contains(query)) {
          tempListData.add(item);
        }
      });
      setState(() {
        queriedGymNames.clear();
        queriedGymNames.addAll(tempListData);
      });
      return;
    } else {
      setState(() {
        queriedGymNames.clear();
        queriedGymNames.addAll(tempSearchList);
      });
    }
  }

  void selectedList(String query) {
    selectedSessions.clear();
    if (query.isNotEmpty) {
      for (var s in sessions) {
        if (s.getGym().contains(query)) {
          setState(() {
            selectedSessions.add(s);
          });
        }
      }
    } else {
      setState(() {
        selectedSessions.clear();
        selectedSessions.addAll(sessions);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startMethod();
  }

  startMethod() async {
    await _getSessions();
    setState(() {
      _loaded = true;
    });
  }
}
