import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class EquipmentOrExercise extends StatefulWidget {
  @override
  _EquipmentOrExerciseState createState() => _EquipmentOrExerciseState();
}

class _EquipmentOrExerciseState extends State<EquipmentOrExercise> {
  String title = 'Equipment';
  int _selectedIndex = 0;


  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: List of equipment',

    ),
    Text(
      'Index 1: List of exercises',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex != 0){
        title = 'Exercises';
      }else{
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
       /*
        child: Container(
          padding: EdgeInsets.all(18),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 150,
                height: 50,
                child: RaisedButton.icon(
                  color: Color(0xFF84329b),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => null));
                  },
                  icon: Icon(
                    Icons.category,
                    color: Color(0xFFfffad9),
                  ),
                  label: Text(
                    'Equipment',
                    style: TextStyle(
                      color: Color(0xFFfffad9),
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                child: RaisedButton.icon(
                  color: Color(0xFF84329b),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => null));
                  },
                  icon: Icon(
                    Icons.airline_seat_legroom_reduced,
                    color: Color(0xFFfffad9),
                  ),
                  label: Text(
                    'Exercises',
                    style: TextStyle(
                      color: Color(0xFFfffad9),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        */
      ),
    );
  }
}
