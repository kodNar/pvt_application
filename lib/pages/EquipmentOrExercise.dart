import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
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
  String title = 'Equipment';
  int _selectedIndex = 0;

  _EquipmentOrExerciseState(OutdoorGym outdoorGym) {
    this.outdoorGym = outdoorGym;
  }

  @override
  void initState() {
    super.initState();
  }

  _populateEquipmentList() async {
    equipmentList.clear();
    equipmentList.addAll(await outdoorGym.getEquipmentFromDB());
    for (Equipment equip in equipmentList) {
      print(equip);
    }
    return equipmentList;
  }

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: List of exercises',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex != 0) {
        title = 'Exercises';
      } else {
        title = 'Equipment';

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
    print('test #1');
    return FutureBuilder(
        future: _populateEquipmentList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      for(Exercise exc in equipmentList[index].getExercises())
                        print(exc.name);
                    },
                    title: Text('${equipmentList[index].getName()}'),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
  Widget exerciseListview() {
    print('test #1');
    return FutureBuilder(
        future: _populateEquipmentList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      print('hej');
                      print(equipmentList[index]);
                      print(equipmentList[index].getExercises().length);
                     for(Exercise exc in equipmentList[index].getExercises())
                      print(exc);
                    },
                    title: Text('${equipmentList[index].getName()}'),
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
