import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
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
  PrivateWorkoutPage(this.ex, this._name);
  @override
  _PrivateWorkoutState createState() => _PrivateWorkoutState(ex,_name);
}

class _PrivateWorkoutState extends State<PrivateWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exerciseList;
  OutdoorGym outdoorGym;
  String _name;


  _PrivateWorkoutState(List<Exercise> ex, String name) {
    this._name = name;
    this.exerciseList = ex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: _name,
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              workoutsItemList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.share),
        label: const Text('Share'),
        onPressed: () {
          //share function
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  @override
  void initState() {
    super.initState();
    print(exerciseList.length);
  }


    Widget workoutsItemList(){
    return Expanded(child:ListView.builder(
      itemCount: exerciseList.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Card(
            color: Colors.purple,
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(exerciseList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 23,

            )),
                ),
                Container(child:setWidget(index)),
                Container(),
              ],
            ),
          );
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
  }

