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

class PublicWorkoutPage extends StatefulWidget {
  String _name ="";
  List <Exercise> ex = [];
  PublicWorkoutPage(this.ex, this._name);
  @override
  _PublicWorkoutState createState() => _PublicWorkoutState(ex,_name);
}

class _PublicWorkoutState extends State<PublicWorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exercise> exerciseList;
  OutdoorGym outdoorGym;
  String _name;


  _PublicWorkoutState(List<Exercise> ex, String name) {
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
              workoutsItemList(),
                bottomAppBar(),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.blue,
        label: const Text('Start this exercise'),
        onPressed: () {
          //share function
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  @override
  void initState() {
    super.initState();
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
                  width: MediaQuery.of(context).size.width-20 ,
                  child: Text(exerciseList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 23,
                      )),
                ),
                Container(child:setWidget(index)),

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
          ],);
        }
    );
  }
  Widget bottomAppBar() {
    return  BottomAppBar(

      child: Row(
        children: <Widget>[
          Flexible(child: Post(),),
          Spacer(),
          Spacer(),
          Flexible(child:Favorit(),),

      ],)
    );
  }

}
class Post extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new PostState();
  }

class PostState extends State<Post>{
  bool liked =false;

  _pressed() {
  setState(() {
    liked = !liked;
  });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              },
            ),
          )
        ],
      )
    );
  }
}
class Favorit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new FavoritState();
}

class FavoritState extends State<Favorit>{
  bool favorit =false;

  _pressed() {
    setState(() {
      favorit = !favorit;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child:Column(
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon:Icon(favorit ? Icons.star: Icons.star_border),
                color: favorit? Colors.amber: Colors.black26,
                iconSize: 50,
                onPressed: () {
                  _pressed();
                },
              ),
            )
          ],
        )
    );
  }
}

