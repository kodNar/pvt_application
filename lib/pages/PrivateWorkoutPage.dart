import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
import 'package:flutterapp/pages/StartWorkout.dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/services/Database.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';



import 'MapsTest.dart';

class PrivateWorkoutPage extends StatefulWidget {
  String _name ="";
  List <Exercise> ex = [];
  WorkoutSession session;


  PrivateWorkoutPage(this.ex, this._name, this.session);
  @override
  _PrivateWorkoutState createState() => _PrivateWorkoutState(ex,_name, session);
}

class _PrivateWorkoutState extends State<PrivateWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exerciseList;
  OutdoorGym outdoorGym;
  String _name;
  FirebaseUser _user;
  WorkoutSession session;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _PrivateWorkoutState(List<Exercise> ex, String name, WorkoutSession s) {
    this._name = name;
    this.exerciseList = ex;
    this.session =s;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: _name,
      ),
      key:_scaffoldKey,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
    Color.fromARGB(255, 132, 50, 155),
    Color.fromARGB(255, 132, 50, 155),
    Color.fromARGB(255, 144, 55, 169),
    Color.fromARGB(255, 157, 97, 173),
    Color.fromARGB(255, 198, 93, 200),
      Color.fromARGB(255, 184, 75, 214),
    ]),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              workoutsItemList()
            ],
          ),

      )),
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Spacer(),
        FloatingActionButton.extended(
          elevation: 4.0,
          backgroundColor: Colors.amber,
          icon: const Icon(Icons.share),
          label: const Text('Share'),
          onPressed: () {
            if(!session.shared) {
              _showDialog();
            }else{
              _showDialogAlreadyShared();
            }
          },
        ),
      Spacer(),
          ButtonTheme(
            height: 50.0,
      child: RaisedButton(
        child: Text("Start Workout",style: TextStyle(fontSize: 16, color: Colors.white,),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
        ),
        onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => StartWorkout(exerciseList, _name,)));
        },
        color: Colors.blue,
      ),),Spacer(),
      ],),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  getUsers() async{
    _user = await FirebaseAuth.instance.currentUser();
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

    createNewExercises(var ref) async {

      for(var exercise in exerciseList){
      await Firestore.instance.collection("Workouts").document(ref).collection("Exercises").document().setData({
        'Name': exercise.name,
        'Reps':exercise.reps,
        'Sets':exercise.sets,
      }
      );

  }
  }
  shareWorkout(){
    session.shared = true;
    String ref = Firestore.instance.collection("Workouts").document().documentID;
    createNewExercises(ref);
    Firestore.instance.collection("Workouts").document(ref).setData({'Shared':true});
    Firestore.instance.collection("Workouts").document(ref).setData({
      'Difficulty':session.difficulty,
      'Favorits': 0,
      'Likes': 0,
      'Location': session.location,
      'Name': session.name,
      'Published': DateTime.now(),
      'User':_user.displayName,
      'Reference': ref,
    });
    final snackBar = SnackBar(
      content: Text(
        "Your workout has been shared, it can be seen at discover workouts",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Share"),
          content: new Text("Are you sure you want to share your workout?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Share"),
              onPressed: () {
                shareWorkout();
                Navigator.of(context).pop();
              },

            ),
            FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )],
        );
      },
    );
  }
  
  void _showDialogAlreadyShared() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Share"),
          content: new Text("Your workout is already shared"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Ok!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

