import 'dart:async';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/Library.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/pages/AboutUs.dart';
import 'package:flutterapp/pages/FAQ.dart';
import 'package:flutterapp/pages/ReportPage.dart';
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
import '../Equipment.dart';
import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  static List<OutdoorGym> allOutdoorGym = [];
  Map map = new Map<String, List<OutdoorGym>>();
  static const nycLat = 59.328560;
  static const nycLng = 18.065836;
  bool _loggedIn = false;
  bool _cancelButton = false;

  GoogleMapPolyline _googleMapPolyline =
      new GoogleMapPolyline(apiKey: (apiKey));
  List<LatLng> routeCoords;
  final Set<Polyline> polyline = {};

  static const apiKey = 'AIzaSyCzAqwpJiXg8YdVDxNGB4BHm2oMslsMTqs';
  bool mapToggle = false;
  var currentLocation;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Stockholm outdoor gyms"),
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
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.all(10),
                      child: _cancelButton
                          ? ClipOval(
                              child: Material(
                                color: Colors.red, // button color
                                child: InkWell(
                                  splashColor: Colors.white, // inkwell color
                                  child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: Icon(Icons.cancel)),
                                  onTap: () {
                                    setState(() {
                                      polyline.clear();
                                      _cancelButton = !_cancelButton;
                                    });
                                  },
                                ),
                              ),
                            )
                          : Center()),
                ])
              : Center(
                  child: Text('Loading...'),
                ),
        ),
        Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 7) * 2,
            child: listView2()),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        currentLocation = LatLng(59.3274, 18.055);
        mapToggle = true;
      });
    });
    populateOutdoorGymList();
    checkIfSignedIn();
  }

  /// Loads the outdoorgyms from the database and populates the outdoor gym list.
  populateOutdoorGymList() async {
    QuerySnapshot outdoorGymCollection =
        await Firestore.instance.collection("OutdoorGyms").getDocuments();
    for (var doc in outdoorGymCollection.documents) {
      String name = doc.data['Name'];
      GeoPoint geoPoint = doc.data['GeoPoint'];
      List<String> equipmentListRef = [];
      if (doc.data['Equipment'] != null) {
        equipmentListRef.addAll(_getReferenceToEquipment(doc));
      }
      try {
        allOutdoorGym
            .add(new OutdoorGym(name, equipmentListRef, geoPoint, context));
      } catch (e) {
        print("Error creating gym");
      }
    }
    _addGymsToMarkers();
    libraryEq();
  }

  List<String> _getReferenceToEquipment(var doc) {
    List<String> output = [];
    try {
      List<Object> objectList = doc.data['Equipment'];
      objectList.forEach((e) => output.add(e.toString()));
    } catch (e) {
      print("Error creating Equipment Reference");
      return output;
    }
    return output;
  }

  libraryEq() {
    for (OutdoorGym outdoorGym in allOutdoorGym) {
      for (String equipment in outdoorGym.equipmentRef) {
        List<OutdoorGym> list = map[equipment];
        if (map.containsKey(equipment)) {
          if (list == null) {
            list.add(outdoorGym);
            map[equipment] = list;
          }
          if (!list.contains(outdoorGym)) {
            list.add(outdoorGym);
            map[equipment] = list;
          }
        } else {
          List<OutdoorGym> gymList = [];
          gymList.add(outdoorGym);
          //map.putIfAbsent(equipment, () => gymList);
          map[equipment] = gymList;
        }
      }
    }
    for (final name in map.keys) {
      var value = map[name];
      for (OutdoorGym obj in value) {
        print(obj.toString());
      }
      print('$name'); // prints entries like "AED,3.672940"
    }
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
    currentLocation = await Geolocator().getCurrentPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        tilt: 0,
        zoom: 17)));
  }

  getSomePoints(var goal) async {
    polyline.clear();
    //currentLocation = await Geolocator().getCurrentPosition();
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
        future: _getSortedListOnDistance(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        int key = snapshot.data.keys.elementAt(index);
                        OutdoorGym value =
                            snapshot.data.values.elementAt(index);
                        return Column(
                          children: <Widget>[
                            Container(
                                color: Color.fromARGB(255, 132, 50, 155),
                                height: 50,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            _goToGym(value);
                                          },
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(fontSize: 16.0),
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
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
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              text: key.toString() + "m"),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: SizedBox(
                                            child: RaisedButton.icon(
                                              icon: Icon(
                                                Icons.play_arrow,
                                              ),
                                              color: Colors.white,
                                              label: Text('Show route'),
                                              onPressed: () {
                                                setState(() {
                                                  route = !route;
                                                  _cancelButton = true;
                                                });
                                                getSomePoints( LatLng(value.geo.latitude,value.geo.longitude));
                                                _goToGym(value);
                                              },
                                            )),
                                      )
                                    ])
                            ),
                            Divider(
                              color: Colors.white,
                              height: 2,
                            )
                          ],
                        );
                      }))
              : Center(child: CircularProgressIndicator());
        });
  }

  checkIfSignedIn() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
    });
  }

  Future<SplayTreeMap> _getSortedListOnDistance() async {
    SplayTreeMap st = new SplayTreeMap<int, OutdoorGym>();
    for (int i = 0; i < allOutdoorGym.length; i++) {
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
    return Container(
      width: 180,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF84329b),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text('Workout Logs'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => WorkoutPortal()));
              }
            ),
            ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Library'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Library(map)));
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('About us'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQ'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FAQ()));
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem),
              title: Text('Report Issue'),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ReportPage()));
              },
            ),
            _loggedIn
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      setState(() {
                        FirebaseAuth.instance.signOut();
                        _loggedIn = false;
                      });
                    },
                  )
                : Center(
                    child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Login'),
                    onTap: () {
                      if (_loggedIn) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MapSample()));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
