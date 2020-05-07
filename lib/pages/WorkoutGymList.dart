import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/pages/MapsTest.dart';

class WorkoutGymList extends StatefulWidget {
  @override
  _WorkoutGymListState createState() => _WorkoutGymListState();
}

class _WorkoutGymListState extends State<WorkoutGymList> {
  List<OutdoorGym> allOutdoorGym = MapSampleState.allOutdoorGym;

  @override
  Widget build(BuildContext context) {
    printList();
    return Scaffold(
      backgroundColor: Color(0xFF84329b),
      appBar: BaseAppBar(
        title: 'Choose gym',
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(

                  labelText: "Search",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allOutdoorGym.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(allOutdoorGym[index].name),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void printList() {
    print(allOutdoorGym.length);
    for (OutdoorGym gym in allOutdoorGym) {
      print(gym);
    }
  }
}
