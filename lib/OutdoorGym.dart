import 'package:flutter/material.dart';
import 'package:flutterapp/pages/GenericGymPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Init firestore and geoFlutterFire
Geoflutterfire geo = Geoflutterfire();
Firestore _firestore = Firestore.instance;

class OutdoorGym{
  String _name;
  GeoPoint _geo;

  //later be equipmmnt insted of string
  List<String> equipments= [];
  Marker _marker;

  //home/office/unknown

  OutdoorGym(String name,GeoPoint geo,context){
    this._name= name;
    this._geo = geo;

    this._marker = new Marker(
        markerId: MarkerId (name),
        position: LatLng (this._geo.latitude,this._geo.longitude),
        onTap:(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GenericGymPage(_name, equipments)));
        },
        draggable: false
    );


  }



  Marker get marker => _marker;
  String get name => _name;
  GeoPoint get geo => _geo;
  @override
  String toString() {
    return 'OutdoorGym{_name: $_name, _geo: $_geo}';
  }

}