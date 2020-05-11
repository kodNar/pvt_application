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
  List<String> allGymNames = List<String>();
  List<String> queriedGymNames = List<String>();
  TextEditingController editingController = TextEditingController(); //For search
@override
void initState() {
  for(OutdoorGym gym in allOutdoorGym){
    queriedGymNames.add(gym.name);
    allGymNames.add(gym.name);
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value){
                searchFilter(value);
              },
              controller: editingController,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5,
                  ),
                    borderRadius: BorderRadius.all(Radius.circular(25.0,)
                    ),
                ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(Icons.search,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: queriedGymNames.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context, (queriedGymNames[index]));
                      },
                    title: Text('${queriedGymNames[index]}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchFilter(String query) {
    List<String> tempSearchList = List<String>();
    tempSearchList.addAll(allGymNames);
    print('Tempsearch list: $tempSearchList'.length);
    if(query.isNotEmpty) {
      List<String> tempListData = List<String>();
      tempSearchList.forEach((item) {
        if(item.contains(query)) {
          tempListData.add(item);
        }
      });
      setState(() {
        queriedGymNames.clear();
        queriedGymNames.addAll(tempListData);
      });
      return;
    } else {
      setState(() {
        queriedGymNames.clear();
        queriedGymNames.addAll(tempSearchList);
      });
    }
  }
}
