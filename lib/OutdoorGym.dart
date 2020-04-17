import 'package:google_maps_flutter/google_maps_flutter.dart';
class OutdoorGym {
  String name;
  double lat;
  double lng;
  //later be equipmmnt insted of string
  List<String> equipments= [];
  Marker marker;
  //home/office/unknown

  OutdoorGym(String name,String lat,String lng){
   this.name= name;
   this.lat =00;
   this.lng = 00;
   this.marker = new Marker(
     markerId: MarkerId (name),
     position: LatLng (this.lat,this.lng),
       onTap:(){
       //smart shiiit
   },
   draggable: false
   );
  }
}