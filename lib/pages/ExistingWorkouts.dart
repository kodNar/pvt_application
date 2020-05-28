import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/services/Database.dart';
import '../Exercise.dart';
import 'PrivateWorkoutPage.dart';
import 'PublicWorkoutsSession.dart';

class ExistingWorkouts extends StatefulWidget {
  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<ExistingWorkouts> {
  @override
  List<bool> _isSelected = [false, false];
  List<bool> _isSelectedDiff = [true, true, true];
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
            Container(child: _toggleSearch()),
            _toggleSearchLevel(),
            Container(child: _searchField()),

            _loaded
                ? Container(child: _listView())
                : Center(child: Text("Loading..."))
          ],
        ));
  }

  Widget _searchField() {
    return Container(
      padding: EdgeInsets.all(12),
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

  Widget _toggleSearch() {
    return ToggleButtons(
      fillColor: Colors.white70,
      children: <Widget>[
        Container(
          color: Colors.white54,
          width: MediaQuery.of(context).size.width / 2 - 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              "Most Recent",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Icon(Icons.timer,
              color: Colors.purple,

            ),],),
          alignment: Alignment.center,
        ),
        Container(
          color: Colors.white54,
          width: MediaQuery.of(context).size.width / 2 - 1,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            Text(
            "Highest Voted",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
            Icon(Icons.favorite,
              color: Colors.purple,

            ),],),
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
  Widget _toggleSearchLevel() {
    return Container(
        child: Column(children: <Widget>[
          Text('Difficulty',style:TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ) ),Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            FilterChip(
                avatar: _isSelectedDiff[0] ? Icon(Icons.check, color: Colors.deepPurple,) : null,
                label: Text('Beginner',style: TextStyle(
                    fontSize: 16
                ),),
                onSelected: (value) {
                  setState(() {
                    _isSelectedDiff[0] = !_isSelectedDiff[0];
                    filterOnDifficculty();
                  });
                }

            ),
              SizedBox(
                width: 5,
              ),
              FilterChip(
                  avatar: _isSelectedDiff[1] ? Icon(Icons.check, color: Colors.deepPurple,) : null,
                  label: Text('Intermediat',style: TextStyle(
                    fontSize: 16
                  ),),
                  onSelected: (value) {
                    setState(() {
                      _isSelectedDiff[1] = !_isSelectedDiff[1];
                      filterOnDifficculty();
                    });
                  }
              ),
              SizedBox(
                width: 5,
              ),
              FilterChip(
                  avatar: _isSelectedDiff[2] ? Icon(Icons.check, color: Colors.deepPurple,) : null,
                  label: Text('Advanced',style: TextStyle(
                      fontSize: 16
                  ),),
                  onSelected: (value) {
                    setState(() {
                      _isSelectedDiff[2] = !_isSelectedDiff[2];
                      filterOnDifficculty();
                    });
                  }
              ),
          ],),

        ],
     ));
  }

  filterOnDifficculty(){
    print(_isSelectedDiff.toString());
    List <WorkoutSession> tempList = [];
    List <int> filters = [];
    int i = 0;
    for(bool toggle in _isSelectedDiff){
      if(toggle){
        filters.add(i);
      }
      i++;
    }
    for  (WorkoutSession session in sessions){
      if(filters.contains(session.difficulty))
        tempList.add(session);
    }
    selectedSessions = tempList;
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
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                          //Text(sessions[index].likes.toString()),
                                          Text(selectedSessions[index]
                                              .likes
                                              .toString(), style: TextStyle(color: Colors.white)),
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                          ),
                                          Text(selectedSessions[index]
                                              .favoris
                                              .toString(), style: TextStyle(color: Colors.white)),
                                        ],
                                      )),

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
    List<String> favRef =(await DatabaseService(uid:_user.uid).getFavRef());
    for (var doc in workoutsCollection.documents) {
      List<Exercise> exercisesList = await getExercises(doc.documentID);
      String ref = doc.documentID;
      String name = doc.data['Name'];
      int likes = (doc.data['Likes']);
      int favs = (doc.data['Favorits']);
      String location = doc.data['Location'];
      String user = doc.data['User'];
      DateTime date = (doc.data['Published'] as Timestamp).toDate();
      int difficulty  =doc.data['Difficulty'];

      WorkoutSession w =
      WorkoutSession(name, user, location, date, null, null, exercisesList,null, difficulty);
      w.setLikes(likes);
      w.favoris = favs;
      w.reference = ref;
      w.difficulty = difficulty;
      sessions.add(w);
      if(likedRef.contains(ref)){
        w.liked =true;
      }
      if(favRef.contains(ref)){
        w.fav =true;
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
