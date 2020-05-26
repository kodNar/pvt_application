import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/services/Database.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';



import 'MapsTest.dart';
import 'StartWorkout.dart';

class PublicWorkoutPage extends StatefulWidget {
  String _name ="";
  List <Exercise> ex = [];
  PublicWorkoutPage(this.ex, this._name,this.session);
  WorkoutSession session;
  @override
  _PublicWorkoutState createState() => _PublicWorkoutState(ex,_name,session);
}

class _PublicWorkoutState extends State<PublicWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exerciseList;
  OutdoorGym outdoorGym;
  String _name;
  WorkoutSession session;

  FirebaseUser user;


  _PublicWorkoutState(List<Exercise> ex, String name,WorkoutSession w) {
    this._name = name;
    this.exerciseList = ex;
    this.session =w;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: _name,
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Center(child:Container(decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 132, 50, 155),
                Color.fromARGB(255, 132, 50, 155),
                Color.fromARGB(255, 144, 55, 169),
                Color.fromARGB(255, 184, 75, 214),
                Color.fromARGB(255, 157, 97, 173),
                Color.fromARGB(255, 198, 93, 200),
              ])),
        child: Form(
          child: Column(
            children: <Widget>[
              workoutsItemList(),
                bottomAppBar(),

            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.blue,
        label: const Text('Start this exercise'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StartWorkout(exerciseList,_name,)));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }


  Widget workoutsItemList(){
    return Expanded(child:ListView.builder(
        itemCount: exerciseList.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(exerciseList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 23,color: Colors.white,

                      )),
                ),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[

                      Container(child:setWidget(index)),
                      Container(),
                    ],
                  ),
                )
              ]);
        }
    ));
  }
  Widget setWidget(int i){
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: exerciseList[i].sets,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Row(children: <Widget>[

            Container(child: Text((index+1).toString()+".",
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20,

              ),

            )),
            Container(child: Text("               Reps:  ")),
            Container(child: Text(exerciseList[i].reps.toString()),),
          ],);
        }
    );
  }
  Widget bottomAppBar() {
    return  BottomAppBar(

        child: Row(
          children: <Widget>[
            Flexible(child: _LikeButton(),),
            Spacer(),
            Spacer(),
            Flexible(child:_FavoritButton(),),

          ],)
    );
  }
  bool liked =false;
  Widget _LikeButton(){
    return Container(
        child:Column(
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon:Icon(liked ? Icons.favorite: Icons.favorite_border),
                color: liked? Colors.red: Colors.black26,
                iconSize: 50,
                onPressed: () {
                  _pressed();
                  //
                },
              ),
            )
          ],
        )
    );
  }
  _pressed() {
    if (!liked) {
      Firestore.instance.collection('Workouts')
          .document(session.reference)
          .updateData({
        'Likes': session.likes + 1});
      session.setLikes(session.likes+1);
    } else {
      Firestore.instance.collection('Workouts')
          .document(session.reference)
          .updateData({
        'Likes': session.likes - 1});
      session.setLikes(session.likes - 1);
    }
    setState(() {
      liked = !liked;
    });
  }
  bool _favorit = false;
  Widget _FavoritButton(){
    return Container(
        child:Column(
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon:Icon(_favorit ? Icons.star: Icons.star_border),
                color: _favorit? Colors.amber: Colors.black26,
                iconSize: 50,
                onPressed: () {
                  _pressedFav();
                },
              ),
            )
          ],
        )
    );
  }
  _pressedFav() {
    DatabaseService(uid:user.uid).addToFavorit(session);
    setState(() {
      _favorit = !_favorit;
    });

  }
  getUser()async{
    user  = await  FirebaseAuth.instance.currentUser();
  }
}
