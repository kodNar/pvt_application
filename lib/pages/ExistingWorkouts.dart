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
  List <WorkoutSession>  sessions= [];
  bool _loaded = false;
  String searchGym = "";

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

            Container(child: _toggleSearch()), //byt vad som visas
            Container(child: _searchField()),
            _loaded? Container(child: _listView()) :Center()
          ],
        ));
  }
  Widget _searchField(){
    return Container(
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
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        onSaved: (input) => searchGym = input,
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
                          itemCount: sessions.length,
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
                                            child: Text(sessions[index].name),
                                          ),
                                          Container(child: Text(" Location: ")),
                                          Container(child: Text("Likes " + sessions[index].likes.toString()),)
                                        ])));
                          })));
  }

    _getSessions() async {
    QuerySnapshot workoutsCollection =
    await Firestore.instance.collection("Workouts").getDocuments();
    for (var doc in workoutsCollection.documents) {
      String name = doc.data['Name'];
      int likes = (doc.data['Likes']);
      String location = doc.data['Location'];
      String user =doc.data['User'];
      DateTime date = (doc.data['Published']as Timestamp).toDate();
      WorkoutSession w = WorkoutSession(name,user,location,date,null, null);
      w.setLikes(likes);
      sessions.add(w);
    }
  }
 sortListVoted(){
    print("sort voted");
   sessions.sort((a,b){
     return b.likes.compareTo(a.likes);
   });
 }
  sortListRecent(){
    sessions.sort((a,b){
      return b.getDateTime().compareTo(a.getDateTime());
    });
  }
  @override
  void initState() {
    super.initState();
      setState(() {
        _loaded = true;
      });
    _getSessions();
  }
}
