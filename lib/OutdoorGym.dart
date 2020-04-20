import 'package:flutter/material.dart';
import 'package:flutterapp/GenericGymPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class OutdoorGym{
  String _name;
  double _lat;
  double _lng;
  //later be equipmmnt insted of string
  List<String> equipments= [];
  Marker _marker;
  //home/office/unknown

  OutdoorGym(String name,String lat,String lng,context){
    this._name= name;
    this._lat = double.parse(lat);
    this._lng = double.parse(lng);
    this._marker = new Marker(
        markerId: MarkerId (name),
        position: LatLng (this._lat,this._lng),
        onTap:(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GenericGymPage(_name, equipments)));
        },
        draggable: false
    );

    print("OutdoorGym{_name: $_name, _lat: $_lat, _lng: $_lng}");
  }

  Marker get marker => _marker;

  @override
  String toString() {
    return 'OutdoorGym{_name: $_name, _lat: $_lat, _lng: $_lng}';
  }

}