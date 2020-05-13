import 'package:flutter/material.dart';
import 'package:flutterapp/Exercise.dart';
import 'package:flutterapp/pages/GenericGymPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Equipment.dart';

// Init firestore and geoFlutterFire
Geoflutterfire geo = Geoflutterfire();
Firestore _firestore = Firestore.instance;

class OutdoorGym{
  String _name;
  GeoPoint _geo;

  //later be equipmmnt insted of string
  List<String> _equipmentRef= [];
  Marker _marker;
  List <Equipment> _equipment=[];

  //home/office/unknown

  OutdoorGym(String name, List<String> equipment, GeoPoint geo,context){
    this._name= name;
    this._geo = geo;
    this._equipmentRef = equipment;

    this._marker = Marker(
        markerId: MarkerId (name),
        position: LatLng (this._geo.latitude,this._geo.longitude),
        onTap:(){

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GenericGymPage(this, _equipmentRef)));
        },
        draggable: false
    );
  }
  Future <List<Equipment>> getEquipmentFromDB() async {
    if(_equipment.length == 0){
      print("getting from db");
    for(var ref in _equipmentRef){
      List<Exercise> exercises =[];
      var temp = (await Firestore.instance.collection('Equipment').document(ref).get());
      var exerTemp = await Firestore.instance.collection('Equipment').document(ref).collection("Exercises").getDocuments();
      for(var doc in exerTemp.documents) {
      Exercise e = Exercise(doc.data['Name'],doc.data['Desc']);
      if(e != null) {
        exercises.add(e);
      }}
      Equipment equipment = Equipment(temp.documentID.toString(),exercises);
      _equipment.add(equipment);
    }
  }
      return _equipment;
    }

  Marker get marker => _marker;
  String get name => _name;
  GeoPoint get geo => _geo;
  @override
  String toString() {
    return 'OutdoorGym{_name: $_name, _geo: $_geo}';
  }
}