import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/pages/EquipmentSelection.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/pages/PopularHours.dart';


class GenericGymPage extends StatefulWidget {
  OutdoorGym outdoorGym;
  List<String> _equipmentRef = [];

  GenericGymPage(OutdoorGym outdoorGym,List <String> eq) {
    this.outdoorGym = outdoorGym;
    this._equipmentRef = eq;
  }
  @override
  State <GenericGymPage> createState() => GenericState(outdoorGym,_equipmentRef);
  }

  class GenericState extends State< GenericGymPage> {
    String _name;
    List<String> _equipmentRef = [];
    List<Equipment> _equipment = [];
    OutdoorGym _outdoorGym;

    GenericState(OutdoorGym outdoorGym,List <String> eq) {
      this._name = outdoorGym.name;
      this._equipmentRef = eq;
      this._outdoorGym = outdoorGym;
    }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 132, 50, 155),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_name),
          ),
      body: Builder(builder: (context) {
        return Stack(children: [
          Container(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/OutdoorGymPicture.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(child:Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentSelection(_name, _equipment)));
                            },

                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/Traning.png',
                                      height: 40.0,
                                      width: 40.0,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 65.0),
                                        child: Text(
                                          "Equipment",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),

                                       ))
                                  ],
                                ))),
                      ),

                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PopularHours(_name)));
                            },

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/bok.png',
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 65.0),
                                      child: Text(
                                        "Busy hours",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            )),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.white, width: 1.5),
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              /*Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AboutGymsPage()));*/
                            },

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/bok.png',
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 90.0),
                                      child: new Text(

                                        "About",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          )),
                    ]),

              ),
                    ),
              Container(
                  child: Text(
                    "Contact us / report",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,

                    ),
                  )),

            ]),
          ),
        ]);
      }),
    );
  }
    _populateEquipment() async{
     _equipment.addAll(await _outdoorGym.getEquipmentFromDB());
    }
  @override
  void initState() {
    super.initState();
    _populateEquipment();
  }
}
