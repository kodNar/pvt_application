import 'dart:async';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/pages/AboutUs.dart';
import 'package:flutterapp/pages/FAQ.dart';
import 'package:flutterapp/pages/OnBoardPage.dart';
import 'package:flutterapp/pages/Profile.dart';
import 'package:flutterapp/pages/ReportPage.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'LibraryEx.dart';
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
      title: Text(
        "Stockholm Outdoor Gyms",
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
    );
    return Scaffold(
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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          _cancelButton
                              ? FlatButton(
                                  color: Color(0xFF84329b),
                                  onPressed: () {
                                    setState(() {
                                      polyline.clear();
                                      _cancelButton = !_cancelButton;
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      'Cancel route',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(),
                          /*
                          _cancelButton ? ClipOval(
                            child: Material(
                              color: Colors.red, // button color
                              child: InkWell(
                                splashColor: Colors.white, // inkwell color
                                child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Icon(Icons.cancel)),
                                onTap: () {
                                  setState(() {
                                    polyline.clear();
                                    _cancelButton = !_cancelButton;
                                  });
                                },
                              ),
                            ),
                          ) : Center(),
                          */
                        ],
                      )),
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
    ///set current location and toggle map on
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
    populateOutdoorGymList();
    checkIfSignedIn();
  }

  /// Loads the outdoorgyms from the database and populates the outdoor gym list.
  populateOutdoorGymList() async {
    if(allOutdoorGym.length == 0){
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
    else return;
  }
  ///gets keys to equipment object in databas
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
    ///adds equipment as a key with a list of outdoorgyms whit that equipment
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

  ///adds the gyms marker to the set of markers
  _addGymsToMarkers() {
    for (int i = 0; i < allOutdoorGym.length; i++) {
      allMarkers.add(allOutdoorGym[i].marker);
    }
    setState(() {
      Set.from(allMarkers);
    });
  }

  ///Take a target destination and displayes a route on the map
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
 ///Bottom listview displays the list with the closest gyms.
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
                                            strutStyle:
                                                StrutStyle(fontSize: 16.0),
                                            text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                text: value.name),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              StrutStyle(fontSize: 16.0),
                                          text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                          label: Text(
                                            'Show route',
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              route = !route;
                                              _cancelButton = true;
                                            });
                                            getSomePoints(LatLng(
                                                value.geo.latitude,
                                                value.geo.longitude));
                                            _goToGym(value);
                                          },
                                        )),
                                      )
                                    ])),
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
 ///cheacks if user is sign in
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
  ///returns a list of outdoorgyms sorted on the distance to the user
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

  /// moves camarea to the inputed gym
  Future<void> _goToGym(OutdoorGym gym) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(gym.geo.latitude, gym.geo.longitude),
        tilt: 0,
        zoom: 16)));
  }
///menu
  Widget _navDrawer() {
    return Container(
      width: 225,
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
                      image: AssetImage(
                          'assets/images/Stockholm_endast_logga_vit.png'),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                _loggedIn ?
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile())): needToBeLoggedInDialog();

              },
            ),
            ListTile(
                leading: Icon(Icons.directions_run),
                title: Text(
                  'Workout Logs',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  _loggedIn ?
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkoutPortal())): needToBeLoggedInDialog();

                }),
            ListTile(
                leading: Icon(Icons.library_books),
                title: Text(
                  'Exercises and equipment',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LibraryEx(map)));
                }),
            ListTile(
              leading: Icon(Icons.play_circle_outline),
              title: Text(
                'App Tutorial',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OnBoardPage()));
              },
            ),

            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text(
                'About us',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(
                'FAQ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FAQ()));
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem),
              title: Text(
                'Report Issue',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReportPage(null)));
              },
            ),
            _loggedIn
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      title: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        if (_loggedIn) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void needToBeLoggedInDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("To visit this page you need to be logged in"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Take me there"),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
