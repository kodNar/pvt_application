import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/pages/MapsTest.dart';

class ReportGymList extends StatefulWidget {
  @override
  _ReportGymListState createState() => _ReportGymListState();
}
class _ReportGymListState extends State<ReportGymList> {
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
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 132, 50, 155),
        title: Container(
          child: Center(
              child: FittedBox(fit:BoxFit.fitWidth,
                child: Text('Gym list',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )
                ),
              )
//          child: Text(
//            title,
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: 30,
//            ),
//          ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            GeoPoint geoPoint = new GeoPoint(37.422, 122.084);
            OutdoorGym outdoorGym = new OutdoorGym('None', null, geoPoint, context);
            Navigator.pop(context,(outdoorGym));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 40,
            semanticLabel: 'Back',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 40,
              color: Colors.white,
            ),
            tooltip: 'Go to homepage',
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()));
            },
          ),
        ],
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
                      for(OutdoorGym outdoorGym in allOutdoorGym){
                        if(outdoorGym.name == (queriedGymNames[index])){
                          Navigator.pop(context, (outdoorGym));
                        }
                      }
                      //Navigator.pop(context, (queriedGymNames[index]));
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
      //return;
    } else {
      setState(() {
        queriedGymNames.clear();
        queriedGymNames.addAll(tempSearchList);
      });
    }
  }
}
