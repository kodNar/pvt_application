

import 'package:flutter/material.dart';

class GenericGymPage extends StatelessWidget {
  String _name;
  List <String> _equipment = [];


  GenericGymPage(String name, List<String> equipment) {
    this._name = name;
    this._equipment = equipment;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 132, 50, 155),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(_name),
            actions: <Widget>[]),
        body: Builder(
          builder: (context) {
            return Stack(children: [
              Container(
                child: ListView(children: <Widget>[
                  Container(
                    child: Text(_name),
                  ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width*0.5 ,
                  height: MediaQuery.of(context).size.height* 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/OutdoorGymPicture.png'),
                      fit: BoxFit.fill

                    ),
                  ),
                ),
                Container(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.airline_seat_legroom_extra,
                              color: Colors.white,
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color.fromARGB(255, 132, 50, 155),
                            label: Text(
                              "Equipments",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.airline_seat_legroom_extra,
                              color: Colors.white,
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color.fromARGB(255, 132, 50, 155),
                            label: Text(
                              "About",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.airline_seat_legroom_extra,
                              color: Colors.white,
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {},
                            color: Color.fromARGB(255, 132, 50, 155),
                            label: Text(
                              "More",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        )
                        ]
                  ),
                  ),
                ]
            )
              ,
              ),
              ]);
            }
            ),
    );
  }
}


