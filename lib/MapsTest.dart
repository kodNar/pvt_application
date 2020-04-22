import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Marker> allMarkers = [];
  List <OutdoorGym> allOutdoorGym = [];
  static const nycLat = 59.328560;
  static const nycLng = 18.065836;
  static const apiKey = 'AIzaSyCzAqwpJiXg8YdVDxNGB4BHm2oMslsMTqs';

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(nycLat, nycLng),
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
        markers: Set.from(allMarkers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

      ),
      floatingActionButton: FloatingActionButton.extended(

        onPressed:_goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }


  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _asyncMethod() async {
    await _searchNearby();
    print(await loadAsset(context));
    for (int i = 0; i < allOutdoorGym.length; i++) {
      allMarkers.add(allOutdoorGym[i].marker);
    }
  }
  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future<List<String>> _searchNearby() async {
    var dio = Dio();
    var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$nycLat,$nycLng&radius=10000&keyword=utegym&key=$apiKey';
    var response = await dio.get(url, data: null);

    List data1 = response.data['results'];
    data1.forEach((f) =>
        allOutdoorGym.add(new OutdoorGym (
            f["name"].toString(),
            f["geometry"]["location"]["lat"].toString(),
            f["geometry"]["location"]["lng"].toString(),
            context
        )
        )
    );
    return null;
  }

  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/test2.txt');
  }

}
