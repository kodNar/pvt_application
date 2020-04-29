import 'dart:async';
import 'dart:collection';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home:  MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
 State <MapSample> createState() => MapSampleState();
}

class MapSampleState extends State< MapSample> {
  List<Marker> allMarkers = [];
  List<OutdoorGym> allOutdoorGym = [];
  static const nycLat = 59.328560;
  static const nycLng = 18.065836;
  bool _loggedIn = false;
  bool _cancelButton = true;
  GoogleMapPolyline _googleMapPolyline =
  new GoogleMapPolyline(apiKey: (apiKey));
  List<LatLng> routeCoords;
  final Set<Polyline> polyline = {};

  static const apiKey = 'AIzaSyCzAqwpJiXg8YdVDxNGB4BHm2oMslsMTqs';
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
    AppBar appBar = AppBar(
      title: Text("Stockholms outdoor gyms"),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
    );
    return new Scaffold(
      drawer: _navDrawer(),
      appBar: appBar,
      body: Column(children: <Widget>[
        Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height / 7) * 5 -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: mapToggle
              ? Stack(children: <Widget>[
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              //     initialCameraPosition: _kGooglePlex,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation.latitude, currentLocation.longitude),
                zoom: 14.4746,
              ),

              polylines: polyline,
              markers: Set.from(allMarkers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                label: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                child: _cancelButton ? ClipOval(
                  child: Material(
                    color: Colors.red, // button color
                    child: InkWell(
                      splashColor: Colors.white, // inkwell color
                      child: SizedBox(width: 56, height: 56, child: Icon(Icons.cancel)),
                      onTap: () {
                        setState(() {
                          polyline.clear();
                          _cancelButton = false;
                        });
                      },
                    ),
                  ),
                ):Center()
            ),
          ])
              : Center(
            child: Text('Loading...'),
          ),
        ),
        Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 7) * 2,
            child: listView2()),
      ]

      ),

    );
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        //currentLocation = currloc;
        currentLocation = LatLng(59.3274, 18.055);
        mapToggle = true;
      });
    });
    populateOutdoorGymList();

  }

  /// Loads the outdoorgyms from the database and populates the outdoor gym list.
  populateOutdoorGymList() async {
    QuerySnapshot outdoorGymCollection = await Firestore.instance.collection("OutdoorGyms").getDocuments();
    for (var doc in outdoorGymCollection.documents) {
      String name = doc.data['Name'];
      GeoPoint geoPoint = doc.data['GeoPoint'];
      try {
        allOutdoorGym.add(new OutdoorGym(name, geoPoint, context));
      }catch(e){
        print ("Error creating gym");
      }
    }
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

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/files/OutdoorGyms.txt');
  }

  Future<void> _moveCameraToSelf() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        tilt: 0,
        zoom: 15)));
  }

  getSomePoints(var goal) async {
    polyline.clear();
    List<LatLng> points = await _googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(currentLocation.latitude, currentLocation.longitude),
        destination: LatLng(goal.latitude, goal.longitude),
        //destination: LatLng( 32.7764749,-79.9310512,),
        mode: RouteMode.walking);

    setState(() {
      routeCoords = points;
      // change position from onMapCreated(GoogleMapController controller) method
      polyline.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: routeCoords,
        width: 4,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      ));
    });
  }
  Widget listView2() {
    bool route = true;
    return FutureBuilder<SplayTreeMap>(
        future:_getSortedListOnDistance(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(child:ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                int key = snapshot.data.keys.elementAt(index);
                OutdoorGym value = snapshot.data.values.elementAt(index);
                return Container(
                    color: Color.fromARGB(255, 132 + index * 30, 50, 155),
                    height: 50,
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 5,
                            child:InkWell(
                              onTap: () {
                                _goToGym(value);
                              },
                              child:RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 16.0),
                                text: TextSpan(
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                    text: value.name),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 16.0),
                              text: TextSpan(
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                  text: key.toString() + "m"),
                            ),
                          ),

                          Flexible(
                            flex: 2,
                            child:SizedBox(child:RaisedButton.icon(
                              icon: Icon(Icons.play_arrow),
                              color: Color.fromARGB(
                                  255, 200 + index * 30, 50, 155),
                              label: Text(' '),
                              onPressed: () {
                                setState(() {
                                  _cancelButton = true;
                                }
                                );
                                //getSomePoints( LatLng(value.geo.latitude,value.geo.longitude));
                                _moveCameraToSelf();
                              },
                            )),
                          ),
                        ]
                    )
                );

              })
          ) : Center(child: CircularProgressIndicator()
          );


        });
  }

  Future<SplayTreeMap> _getSortedListOnDistance() async{
    SplayTreeMap st = new SplayTreeMap<int, OutdoorGym>();
    for(int i = 0; i< allOutdoorGym.length; i++){
      st[await _calculateDistance(i)] = allOutdoorGym[i];
    }
    return st;
  }

  Future<int> _calculateDistance(int i) async {
    double distance = await Geolocator().distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        allOutdoorGym[i].geo.latitude,
        allOutdoorGym[i].geo.longitude);
    return distance.round();
  }

  Future<void> _goToGym(OutdoorGym gym) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(gym.geo.latitude, gym.geo.longitude),
        tilt: 0,
        zoom: 16)));
  }

  Widget _navDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Stockholm_endast_logga_vit.png'))),
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
          _loggedIn
              ? ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {},
          )
              : Center(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Login'),
                onTap: () => [
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()))
                ],
              ))
        ],
      ),
    );
  }
}
