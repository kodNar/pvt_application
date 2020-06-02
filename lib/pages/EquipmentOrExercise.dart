import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/EquipmentExercisePair.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class EquipmentOrExercise extends StatefulWidget {
  final OutdoorGym outdoorGym;

  EquipmentOrExercise(this.outdoorGym);

  @override
  _EquipmentOrExerciseState createState() =>
      _EquipmentOrExerciseState(outdoorGym);
}

class _EquipmentOrExerciseState extends State<EquipmentOrExercise> {
  OutdoorGym outdoorGym;
  List<Equipment> equipmentList = [];
  List<Exercise> exerciseList = [];
  String title = 'Equipment';
  int _selectedIndex = 0;
  bool exercisePage = false;

  _EquipmentOrExerciseState(OutdoorGym outdoorGym) {
    this.outdoorGym = outdoorGym;
  }

  @override
  void initState() {
    super.initState();
  }

  ///Populates a list with all the equipment from a certain gym
  _populateEquipmentList() async {
    equipmentList.clear();
    equipmentList.addAll(await outdoorGym.getEquipmentFromDB());
    return equipmentList;
  }


  ///Populates a list with all the equipment from a certain gym
  _populateExerciseList() async {
    exerciseList.clear();
    print(exerciseList.length);
    var exercises = await Firestore.instance.collection('ExercisesNoEquip').getDocuments();

    for (var doc in exercises.documents) {
      Exercise e = Exercise(doc.data['Name'], doc.data['Desc']);
      if (e != null) {
        exerciseList.add(e);
      }
    }
    return exerciseList;
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        title = 'Equipment';
        exercisePage = false;
      } else {
        title = 'Exercises';
        exercisePage = true;
        exerciseList.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '$title',
      ),
      backgroundColor: Color(0xFF84329b),
      body: Center(
        child: equipmentListview(),
        //child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Equipment'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            title: Text('Exercises'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF84329b),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget equipmentListview() {
    if (exercisePage) {
      return FutureBuilder(
          future: _populateExerciseList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: exerciseList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${exerciseList[index].getName()}'),
                      onTap: (){
                        Exercise exercise = Exercise(exerciseList[index].getName(), exerciseList[index].getDesc());
                        EquipmentExercisePair equipmentExercisePair = EquipmentExercisePair(null, exercise);
                        Navigator.pop(context, equipmentExercisePair);
                      },
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    } else {
      return FutureBuilder(
          future: _populateEquipmentList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text('${equipmentList[index].getName()}'),
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                equipmentList[index].getExercises().length,
                            itemBuilder: (context, index2) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      '${equipmentList[index].getExercises()[index2].getName()}'),
                                  onTap: () {
                                    EquipmentExercisePair e =
                                        EquipmentExercisePair(
                                            equipmentList[index],
                                            equipmentList[index]
                                                .getExercises()[index2]);
                                    Navigator.pop(context, e);
                                  },
                                ),
                              );
                            }),
                        /*
                      ListTile(onTap: () {
                        print(equipmentList[index]);
                        print(equipmentList[index].getExercises().length);
                        for (Exercise exc in equipmentList[index].getExercises()){
                          print(exc);
                        }
                      }),
                       */
                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    }
  }

  Widget exerciseListView() {
    return FutureBuilder(
        future: _populateExerciseList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text('${equipmentList[index].getName()}'),
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: equipmentList[index].getExercises().length,
                          itemBuilder: (context, index2) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    '${equipmentList[index].getExercises()[index2].getName()}'),
                                onTap: () {
                                  EquipmentExercisePair e =
                                      EquipmentExercisePair(
                                          equipmentList[index],
                                          equipmentList[index]
                                              .getExercises()[index2]);
                                  Navigator.pop(context, e);
                                },
                              ),
                            );
                          }),
                      /*
                      ListTile(onTap: () {
                        print(equipmentList[index]);
                        print(equipmentList[index].getExercises().length);
                        for (Exercise exc in equipmentList[index].getExercises()){
                          print(exc);
                        }
                      }),
                       */
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
