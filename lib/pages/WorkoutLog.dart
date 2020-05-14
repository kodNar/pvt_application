import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/widgets/Appbar.dart';

import 'MapsTest.dart';

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool gymChosen = false;
  bool exerciseChosen = true;
  List<Exercise> exerciseList = [];
  Exercise exercise;
  OutdoorGym outdoorGym;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Workout Log",
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              gymReturn(),
              workoutLog()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Color(0xFF42A5F5),
        icon: const Icon(Icons.add),
        label: const Text('Add exercise/equipment'),
        onPressed: () {
          _pushContextChooseExercise(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              iconSize: 40,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.green,
              iconSize: 40,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget workoutLog() {
    if (exerciseChosen) {
      return Form(
        key: _formKey,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: exerciseList.length,
          itemBuilder: (context, index){
            return Card(
              child: ExpansionTile(
              title: Text('${exerciseList[index].getName()}'),
                children: <Widget>[

                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Sets',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          final isDigitsOnly = int.tryParse(input);
                          return isDigitsOnly == null ? 'Input needs to be digits only' : null;
                        },
                        onSaved: (input) {
                          String sets = input;
                        }

                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Reps',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (input) {
                          final isDigitsOnly = int.tryParse(input);
                          return isDigitsOnly == null ? 'Input needs to be digits only' : null;
                        },
                        onSaved: (input) {
                          String reps = input;

                        },
                      ),
                ],
                trailing: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
            );
          },
        ),
      );
    }else{
      return Text('No exercise chosen');
    }
  }

  Widget gymReturn() {
    if (gymChosen) {
      return Container(
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

  Future<void> saveWorkout() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();
      try {


      } catch (e) {
        print(e.message);
      }
    }
  }

  _pushContextChooseGym(BuildContext context) async {
    final OutdoorGym result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

  _pushContextChooseExercise(BuildContext context) async {
    final Exercise result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentOrExercise(outdoorGym)));
    exerciseList.add(result);
    exerciseChosen = true;
    exercise = result;
  }
}
