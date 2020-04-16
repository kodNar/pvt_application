import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  static const nycLat = 59.328560;
  static const nycLng = 18.065836;
  static const apiKey ='AIzaSyCzAqwpJiXg8YdVDxNGB4BHm2oMslsMTqs';

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(nycLat , nycLng),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(59.328560, 18.065836),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );

  }
  @override
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    print('wefw');
    print(await searchNearby('Food'));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  Future<List<String>> searchNearby(String keyWord) async{
    var dio = Dio();
    var url ='https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    var parameters = {
      'key': apiKey,
      'location': '$nycLat,$nycLng',
      'radius': '2000',
      keyWord: keyWord,
    };
    var response = await dio.get(url,data:parameters);
    return response.data['results']
    .map<String>((result) => result ['name'].toString())
    .toList();
  }

}