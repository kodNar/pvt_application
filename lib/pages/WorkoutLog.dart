import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/EquipmentExercisePair.dart';
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

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class SetFieldValidator {
  static String validate(String input) {
    if (input.length > 0) {
      final isDigitsOnly = int.tryParse(input);
      if (isDigitsOnly <= 0) {
        return 'Input needs to be 1 or higher only';
      }
      if (isDigitsOnly > 99) {
        return 'There is no way you did that amount of sets';
      }
      if (isDigitsOnly == null) {
        return 'Input needs to be digits only';
      }
    }
    return input.isEmpty ? 'Please add at least 1 set' : null;
  }
}

class RepFieldValidator {
  static String validate(String input) {
    if (input.length > 0) {
      final isDigitsOnly = int.tryParse(input);
      if (isDigitsOnly <= 0) {
        return 'Input needs to be 1 or higher';
      }
      if (isDigitsOnly > 999) {
        return 'There is no way you did that amount of reps';
      }
      if (isDigitsOnly == null) {
        return 'Input needs to be digits only';
      }
    }
    return input.isEmpty ? 'Please add at least 1 set' : null;
  }
}

class _WorkoutLogState extends State<WorkoutLog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool editingMode = false;
  bool gymChosen = false;
  bool exerciseChosen = false;
  List<Exercise> exerciseList = [];
  Exercise exercise;
  OutdoorGym outdoorGym;
  FirebaseUser user;
  String _name = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: BaseAppBar(
        title: "Workout Log",
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Form(
        // TODO: Fixa så man kan scrolla ordentligt //Einar
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                gymReturn(),
                workoutLog()
              ],
            ),
          ),
        ),

      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor:  Color(0XFF6a329b),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.white, width: 1.5),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add exercise/equipment'),
        onPressed: () {
          _pushContextChooseExercise(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFededed),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              iconSize: 40,
              onPressed: (){},
              // TODO: Fixa så man kan Ta bort exercises eller hela workout:en //Einar
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.green,
              iconSize: 40,
              onPressed: saveWorkout,
            ),
          ],
        ),
      ),
    );
  }

  void workoutEditMode(){
    if(editingMode){

    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  Widget workoutLog() {
    if (exerciseChosen) {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15,right: 15, bottom: 15),
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
                  prefixIcon: Icon(Icons.text_fields),
                  hintText: "Name of the workout",
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.white,
                // ignore: missing_return
                validator: (input) {
                  if (input.isEmpty) {
                    //Check if auth sign or something
                    return 'Please provide a name for the workout';
                  }
                },
                onSaved: (input) => _name = input,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: exerciseList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Card(
                    child: ExpansionTile(
                      title: Text('${exerciseList[index].getName()}'),
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Sets',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (input) => SetFieldValidator.validate(input),
                            onSaved: (input) {
                              exerciseList[index].setSets(int.tryParse(input));
                            }),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Reps',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (input) => RepFieldValidator.validate(input),
                          onSaved: (input) {
                            exerciseList[index].setReps(int.tryParse(input));
                          },
                        ),
                      ],
                      trailing: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Text('No exercise chosen',
      style: TextStyle(
          fontSize: 18,
        color: Colors.white,
      ),
      );
    }
  }

  Widget gymReturn() {
    if (gymChosen) {
      return Container(
        alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: Text(
              'At the gym: ${outdoorGym.name}',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ButtonTheme(
          minWidth: 250,
          height: 48,
          child: RaisedButton(
            //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            color: Colors.transparent,
            onPressed: () {
              _pushContextChooseGym(context);
            },
            child: Text(
              'Choose gym',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }



  void saveWorkout() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      final snackBar = SnackBar(
        content: Text(
          "Your workout has been saved!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 5),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      for(Exercise exercise in exerciseList){
        print(exercise.name);
        print(exercise.sets);
        print(exercise.reps);
      }
      DatabaseService(uid: user.uid)
          .createNewExercises(exerciseList, outdoorGym, _name);
    }
  }

  _pushContextChooseGym(BuildContext context) async {
    final OutdoorGym result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

  _pushContextChooseExercise(BuildContext context) async {
    final EquipmentExercisePair result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EquipmentOrExercise(outdoorGym)));
    exerciseList.add(result.exercise);
    exerciseChosen = true;
    exercise = result.exercise;
  }
}
