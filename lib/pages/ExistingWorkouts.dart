import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/pages/PublicWorkoutsSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';
import '../Exercise.dart';

class ExistingWorkouts extends StatefulWidget {
  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<ExistingWorkouts> {
  @override
  List<bool> _isSelected = [false, false];
  final List<WorkoutSession> sessions = [];
  List<WorkoutSession> selectedSessions = [];
  List<String> allGymNames = List<String>();
  List<String> queriedGymNames = List<String>();
  bool _loaded = false;
  String searchGym = "";
  FirebaseUser _user;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Discover Workouts",
        ),
        body: Column(
          children: <Widget>[
            // Container(child: _topImage()),
            //Lägg till upload your own workout
            Container(child: _toggleSearch()),
            //byt vad som visas
            // Container(child: _test()),
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
      fillColor: Colors.white70,
      children: <Widget>[
        Container(
          color: Colors.white54,
          width: MediaQuery.of(context).size.width / 2 - 2,
          child: Text(
            "Most Recent",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          alignment: Alignment.center,
        ),
        Container(
          color: Colors.white54,
          width: MediaQuery.of(context).size.width / 2 - 1,
          child: Text(
            "Highest Voted",
            style: TextStyle(
              color: Colors.black,
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
              sortListRecent();
            } else {
              _isSelected[0] = false;
              sortListVoted();
            }
          }
        });
      },
    );
  }

  Widget _listView() {
    return Container(
        child: Expanded(
            child: ListView.builder(
              //itemCount: sessions.length,
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
                                      builder: (context) => PublicWorkoutPage(
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
    QuerySnapshot workoutsCollection =
    await Firestore.instance.collection("Workouts").getDocuments();
    List<String> likedRef =(await DatabaseService(uid:_user.uid).getLikedRef());
    for (var doc in workoutsCollection.documents) {
      List<Exercise> exercisesList = await getExercises(doc.documentID);
      String ref = doc.documentID;
      String name = doc.data['Name'];
      int likes = (doc.data['Likes']);
      String location = doc.data['Location'];
      String user = doc.data['User'];
      DateTime date = (doc.data['Published'] as Timestamp).toDate();
      WorkoutSession w =
      WorkoutSession(name, user, location, date, null, null, exercisesList,null);
      w.setLikes(likes);
      w.reference = ref;
      sessions.add(w);
      if(likedRef.contains(ref)){
        w.liked =true;
      }
      selectedSessions.add(w);
      //sessions = selectedSessions;
    }
  }

  getExercises(var ref) async {
    List<Exercise> exercises = [];
    try {
      QuerySnapshot collectionReferenceExercise = await Firestore.instance
          .collection('Workouts')
          .document(ref)
          .collection("Exercises")
          .getDocuments();
      for (var temp in collectionReferenceExercise.documents) {
        Exercise e = (Exercise(temp.data['Name'], null));
        e.setReps(
          temp.data['Reps'],
        );
        e.setSets(temp.data['Sets']);
        exercises.add(e);
      }
    } catch (e) {
      print("Error message" + e.toString());
    }
    return exercises;
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
    ///Om queryn innehåller något gör detta
    if (query.isNotEmpty) {
      print(query);
      for (var s in sessions) {
        if (s.getGym().toString().contains(query)) {
          setState(() {
            selectedSessions.add(s);
          });
        }
      }
      ///Om queryn är tom gör detta
    } else {
      setState(() {
        selectedSessions.clear();
        selectedSessions.addAll(sessions);
      });
    }
  }

  sortListVoted() {
    print("sort voted");
    selectedSessions.sort((a, b) {
      return b.likes.compareTo(a.likes);
    });
  }

  sortListRecent() {
    selectedSessions.sort((a, b) {
      return b.getDateTime().compareTo(a.getDateTime());
    });
  }

  @override
  void initState() {
    super.initState();
    startMethod();
  }

  startMethod() async {
    _user = await FirebaseAuth.instance.currentUser();
    await _getSessions();
    setState(() {
      _loaded = true;
    });

  }
}
