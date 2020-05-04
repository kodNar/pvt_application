import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class ExistingWorkouts extends StatefulWidget {
  @override
  _ExistingState createState() => _ExistingState();
}

class _ExistingState extends State<ExistingWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: BaseAppBar(
          title: "Existing Workouts",
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(40),
                child: FutureBuilder<List<WorkoutSession>>(
                    future: _getSessions(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        color: Color.fromARGB(
                                            255, 132 + index * 30, 50, 155),
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
                                                  onTap: () {},
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle: StrutStyle(
                                                        fontSize: 16.0),
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        text: 'value.name'),
                                                  ),
                                                ),
                                              ),
                                            ]));
                                  }))
                          : Center();
                    }))));
  }

  Future<List<WorkoutSession>> _getSessions() async {
    return null;
  }
}
