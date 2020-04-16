import 'package:google_maps_flutter/google_maps_flutter.dart';

class OutdoorGym {
  String name;
  double nycLat;
  double nycLng;
  Marker marker;
  //later be equipmmnt insted of string
  List<String> equipments= [];
  //home/office/unknown

  OutdoorGym({this.name, this.nycLat, this.nycLng});
}