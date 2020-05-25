import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/pages/EquipmentOrExercise.dart';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/services/Database.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'MapsTest.dart';

class StartWorkout extends StatefulWidget {
  String _name ="";
  List <Exercise> ex = [];


  StartWorkout(this.ex, this._name);
  @override
  _StartWorkoutState createState() => _StartWorkoutState(ex,_name,);
}

class _StartWorkoutState extends State<StartWorkout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exerciseList;
  OutdoorGym outdoorGym;
  String _name;
  FirebaseUser _user;
  WorkoutSession session;

  _StartWorkoutState(List<Exercise> ex, String name, ) {
    this._name = name;
    this.exerciseList = ex;
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
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    workoutsItemList()
    ],
    ))),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.blue,
        label: const Text('Complete Workout'),
        onPressed: () {
          _showAlertFinsihedWorkout();
        },
      ),
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
            Spacer(),
            ShoppingItemList(CheckBox(false),)],);
        }
    );
  }

  void _showAlertFinsihedWorkout() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>  CupertinoAlertDialog(
          title: Text('Success!'),
          content: _alertContent(),
          actions: <Widget>[
            FlatButton(
              child: Text('Hurra!'),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        )
    );
  }
  Widget _alertContent(){
    return Container(child: Row(children: <Widget>[
      Image.asset('assets/images/borat.Gif'),
    ],),);
  }
  void _showDialogShare() {
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
}
class CheckBox{
  bool isCheck;
  CheckBox(this.isCheck);
}
class ShoppingItemState extends State<ShoppingItemList> {
  final CheckBox product;
  ShoppingItemState(this.product);
  @override
  Widget build(BuildContext context) {
    return Checkbox(
                value: product.isCheck,
                onChanged: (bool value) {
                  setState(() {
                    product.isCheck = value;
                  });
                });
  }
}
class ShoppingItemList extends StatefulWidget {
  final CheckBox product;

  ShoppingItemList(CheckBox product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  ShoppingItemState createState() {
    return new ShoppingItemState(product);
  }
  
  
}
