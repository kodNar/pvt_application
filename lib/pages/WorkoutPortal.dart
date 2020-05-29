import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/DiscoverWorkout.dart';
import 'package:flutterapp/pages/MyWorkout.dart';
import 'package:flutterapp/pages/WorkoutLog.dart';
import 'package:flutterapp/services/Database.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:flutterapp/pages/FavoritWorkouts.dart';

class WorkoutPortal extends StatefulWidget {
  @override
  _WorkoutPortalState createState() => _WorkoutPortalState();
}

class _WorkoutPortalState extends State<WorkoutPortal> {
  String _nickname;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF84329b),
        appBar: BaseAppBar(
          title: 'Workouts',
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FutureBuilder(
                      future: printNickname(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return  Text(
                            'Currently signed in as: $_nickname',
                            style: TextStyle(
                              fontFamily: 'Agency',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}",style: Theme.of(context).textTheme.headline);
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  SizedBox(height: 30),
                  Flexible(
                      flex: 4,
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutLog()));
                    },
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Color(0xFF84329b),
                            Color(0xFF9438ae),
                            Color(0xFFa53fc1),
                            Color(0xFFae52c7),
                            //   Color(0xFFB388FF),
                          ],
                        ),
                      ),
                      child: Text('+ Log New Workout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ),
                  )),
                  SizedBox(height: 30),
                  Flexible(
                      flex: 4,
                      child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => ExistingWorkouts()));
                    },
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(

                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,

                          colors: <Color>[
                            Color(0xFF84329b),
                            Color(0xFF84329b),
                            Color(0xFF9438ae),
                            Color(0xFFa53fc1),
                            Color(0xFFae52c7),
                            /*
                            SNYGGA men fel tema..?
                            Color(0xFF6200EA),
                            Color(0xFF651FFF),
                            Color(0xFF7C4DFF),
                            Color(0xFFB388FF),

                             */

                            /*
                        Color(0xFF5E35B1),
                        Color(0xFF673AB7),
                        Color(0xFF7E57C2),
                        Color(0xFF9575CD),

                         */
                            /*
                        Color(0xFF6A1B9A),
                        Color(0xFF7B1FA2),
                        Color(0xFF8E24AA),
                        Color(0xFF9C27B0),
                        Color(0xFFAB47BC),
                        Color(0xFFBA68C8),
                        */

                          ],
                        ),
                      ),
                      child: Text('Discover Workouts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ),
                  )),
                  SizedBox(height: 30),
                  Flexible(
                      flex: 4,child:InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => MyWorkouts()));
                    },
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,

                          colors: <Color>[
                            Color(0xFF84329b),
                            Color(0xFF84329b),
                            Color(0xFF9438ae),
                            Color(0xFFa53fc1),
                            Color(0xFFae52c7),

                            /*
                            Color(0xFF6200EA),
                            Color(0xFF651FFF),
                            Color(0xFF7C4DFF),
                            Color(0xFFB388FF),

                             */

                            /*
                        Color(0xFF5E35B1),
                        Color(0xFF673AB7),
                        Color(0xFF7E57C2),
                        Color(0xFF9575CD),

                         */
                            /*
                        Color(0xFF6A1B9A),
                        Color(0xFF7B1FA2),
                        Color(0xFF8E24AA),
                        Color(0xFF9C27B0),
                        Color(0xFFAB47BC),
                        Color(0xFFBA68C8),
                        */

                          ],
                        ),
                      ),
                      child: Text('My Workouts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ),
                  )),
                  SizedBox(height: 30),
                  Flexible(
                      flex: 4,child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => FavoritWorkouts()));
                    },
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Color(0xFF84329b),
                            Color(0xFF9438ae),
                            Color(0xFFa53fc1),
                            Color(0xFFae52c7),
                            //   Color(0xFFB388FF),
                          ],
                        ),
                      ),
                      child: Text('Favorite Workouts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ),
                  )),
                ]),
          ),
        ));
  }
  Future<String> printNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String nickNameFromDB = await DatabaseService(uid: user.uid).getNickname();
    _nickname = nickNameFromDB;
    return nickNameFromDB;
  }
}
