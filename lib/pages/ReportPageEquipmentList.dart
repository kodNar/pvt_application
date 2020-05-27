import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class ReportPageEquipmentList extends StatefulWidget {
  final OutdoorGym outdoorGym;

  ReportPageEquipmentList(this.outdoorGym);

  @override
  _ReportPageEquipmentListState createState() =>
      _ReportPageEquipmentListState(outdoorGym);
}

class _ReportPageEquipmentListState extends State<ReportPageEquipmentList> {
  OutdoorGym outdoorGym;
  List<Equipment> equipmentList = [];
  String title = 'Equipment';


  _ReportPageEquipmentListState(OutdoorGym outdoorGym) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: '$title',

      ),
      backgroundColor: Color(0xFF84329b),
      body: Center(
        child: equipmentListview(),

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
                    Navigator.pop(context, equipmentList[index]);
                    },
                    title: Text('${equipmentList[index].getName()}',
                      style: TextStyle(
                      fontFamily: 'OpenSans'
                ),
                  ),
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
