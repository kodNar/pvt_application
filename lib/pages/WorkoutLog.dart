import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/EquipmentExercisePair.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
import 'package:flutterapp/pages/ReportPage.dart';
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
  final ScrollController _scrollController = ScrollController();
  List<TextEditingController> _controllersSet = List();
  List<TextEditingController> _controllersRep = List();
  List <bool> _isSelected = [true,false,false];


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
              onPressed: (){
                removeWorkout();
              },
              // TODO: Fixa så man kan Ta bort exercises eller hela workout:en //Einar
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.green,
              iconSize: 40,
              onPressed: _showDialog,
            ),
          ],
        ),
      ),
    );
  }
/// InitState
  @override
  void initState() {
    super.initState();
    _controllersSet = List();
    _controllersRep = List();
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
            Scrollbar(
              controller: _scrollController,
              child: ListView.builder(

                controller: _scrollController,
                shrinkWrap: true,
                itemCount: exerciseList.length,
                itemBuilder: (context, index) {
                  _controllersSet.add(TextEditingController());
                  _controllersRep.add(TextEditingController());
                  return Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Card(
                      child: ExpansionTile(

                        title: Text('${exerciseList[index].getName()}'),
                        children: <Widget>[
                          TextFormField(

                            controller: _controllersSet[index],
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
                            controller: _controllersRep[index],
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
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
          title: new Text("Difficulty level"),
          content: SizedBox(
            height: 100,
              child: Column(children: <Widget>[
                Text("What difficulty would you say your workout is?"),
            ToggleButtons(
              isSelected: _isSelected,
              onPressed:  (int index) {
                setState(() {
                  if (!_isSelected[index]) {
                    if (index == 0) {
                      _isSelected=[true,false,false];
                    }
                    else if (index == 1) {
                      _isSelected=[false,true,false];
                    }
                    else if (index == 2) {
                      _isSelected=[false,false,true];
                    }
                  }
                });
              },

              children: <Widget>[
              Container(child:Text(" Beginner ")),
              Container(child:Text(" Intermediate ")),
              Container(child:Text(" Advanced ")),
            ],),
          ],)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Save"),
              onPressed: () {
                saveWorkout();
                Navigator.of(context).pop();
              },

            ),
            FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )],
        );});
      },
    );
  }


  void removeWorkout() {
    setState(() {
      print(exerciseList.length);
      if(exerciseList.length < 1){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
             return AlertDialog(
              title:  Text("ERROR: No exercises in the workout"),
              actions: <Widget>[
                FlatButton(
                  child:  Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
               ],
            );
          },
        );
      }else{
        exerciseList.removeLast();
      }
    });
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
      int index = 0;
      for(bool selected in _isSelected){
        if(selected)
          break;
        index++;
      }
      DatabaseService(uid: user.uid)
          .createNewExercises(exerciseList, outdoorGym, _name,index);
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
