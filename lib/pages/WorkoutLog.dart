import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
//import 'package:flutterapp/pages/ExerciseOrEquipment[DEAD].dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/widgets/Appbar.dart';

import 'MapsTest.dart';

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  bool gymChosen = false;
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentOrExercise(outdoorGym)));

        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
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

  Widget gymReturn(){
    if(gymChosen){
      return Container(
        padding: EdgeInsets.all(20),
        child: Text('At the gym: ${outdoorGym.name}',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
      );
    }else{
      return  Container(
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
    final OutdoorGym result = await Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

  _pushContextChooseEquipment(BuildContext context) async {
    final OutdoorGym result = await Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

}
