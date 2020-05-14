import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'MapsTest.dart';

class testis extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<testis> {
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
            children: <Widget>[gymReturn(), workoutLog()],
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
      return ListView.builder(
        shrinkWrap: true,
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('${exerciseList[index].getName()}'),
            ),
          );
        },
      );
    } else {
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

  _pushContextChooseGym(BuildContext context) async {
    final OutdoorGym result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

  _pushContextChooseExercise(BuildContext context) async {
    final Exercise result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EquipmentOrExercise(outdoorGym)));
    exerciseList.add(result);
    exerciseChosen = true;
    exercise = result;
  }
}
