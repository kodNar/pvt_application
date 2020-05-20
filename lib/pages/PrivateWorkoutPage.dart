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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white,Color.fromARGB(255, 132, 50, 155)])),
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
            shareWorkout();
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
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  StartWorkout(exerciseList,_name,)));
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
                    fontSize: 23,

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
            Divider(thickness: 2,
            height: 2,
            color: Colors.white,)
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
    String ref = Firestore.instance.collection("Workouts").document().documentID;
    createNewExercises(ref);
    Firestore.instance.collection("Workouts").document(ref).setData({
      'Likes': 0,
      'Location': session.location,
      'Name': session.name,
      'Published': DateTime.now(),
      'User':_user.displayName
    });
    print("workoutShared");
  }
}

