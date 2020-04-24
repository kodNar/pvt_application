import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geoflutterfire/geoflutterfire.dart';


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
  List<Marker> allMarkers = [];
  List<OutdoorGym> allOutdoorGym = [];
  static const nycLat = 59.328560;
  static const nycLng = 18.065836;

  //static const apiKey = 'AIzaSyCzAqwpJiXg8YdVDxNGB4BHm2oMslsMTqs';
  bool mapToggle = false;
  var currentLocation;
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
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Stockholms outdoor gyms"),
        backgroundColor: Color.fromARGB(255, 132, 50, 155),

      ),
      body: Column(
        children: <Widget>[
        Container(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height/7)*5 - 80,
        child: mapToggle
            ? GoogleMap(
                mapType: MapType.normal,
                //     initialCameraPosition: _kGooglePlex,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 14.4746,
                ),

                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              )
            : Center(

                child: Text('Loading...'),
              ),
      ),
          Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height/7)*2,
              child:ClosestedPlaceContainer(allOutdoorGym,_controller, currentLocation)
          ),
        ]),
    );
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
    _createMarkersFromString();
  }

///////////////////////create  and load markers//////////////////////////////////
  _createMarkersFromString() async {
    ////test////
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 1.960632, longitude: 77.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 13.960632, longitude: 71.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 12.960632, longitude: 71.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 13.0632, longitude: 71.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 12.9632, longitude: 71.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 23.9602, longitude: 71.641603), context));
    allOutdoorGym.add(new OutdoorGym('testo',geo.point(latitude: 3.96632, longitude: 71.641603), context));
    //////////////////////////////test////////////////////////////////////////
    String file = await loadAsset();
    List<String> list = file.split("\n");
    list.forEach((e) {
      if (e != '') {
        List<String> temp = e.split(',');
       //allOutdoorGym.add(new OutdoorGym(temp[0], temp[1], temp[2], context));
      }
    });
    _addGymsToMarkers();
  }

  _addGymsToMarkers() {
    for (int i = 0; i < allOutdoorGym.length; i++) {
      allMarkers.add(allOutdoorGym[i].marker);
    }
    setState(() {
      Set.from(allMarkers);
    });
  }

/*
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
 */

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/files/OutdoorGyms.txt');
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    return controller;
  }

}
class ClosestedPlaceContainer extends StatelessWidget{
  List <OutdoorGym> _list;
  Completer<GoogleMapController> _controller;
  var _userPos;

  ClosestedPlaceContainer(this._list, this._controller,this._userPos);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index){
          return InkWell(
              onTap: (){
                _goToGym(_list[index]);
              },
              child:FutureBuilder<double> (
                future: calculateDistance(index),
                builder: (context, snapshot) {
                  return snapshot.hasData ? Container(
                      color: Color.fromARGB(255, 132 + index * 30, 50, 155),
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_list[index].name),
                            Text(" Distance: " + snapshot.data.toString()+ "m"),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                _goToGym(_list[index]);
                              },
                            ),
                          ])
                  )
                      : Center(
                      child: CircularProgressIndicator());
                }
              )
          );
        }
    );
  }
    Future <double>calculateDistance (int i) async{
    double distance =await Geolocator().distanceBetween( _userPos.latitude, _userPos.longitude, _list[i].geo.latitude, _list[i].geo.longitude);
      return distance;
  }

  Future<void> _goToGym(OutdoorGym gym) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(gym.geo.latitude, gym.geo.longitude),
        tilt: 0,
        zoom: 10)));
  }

}
//////////////////////////////////Menu item////////////////////////////////////////////
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Stockholm',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bok.png'))),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About us'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}