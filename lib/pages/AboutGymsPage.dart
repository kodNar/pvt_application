import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



///Allt på denna sida är för närvarande placeholders, allt kommer fortsätta vara placeholders tills hämtning av all data i konstruktorn lösts
///Krav i databasdokumenten för att implementationen skall fungera enligt förväntan är samtliga fält i konstruktorn.
class AboutGymsPage extends StatelessWidget{
  String _name;
  String _adress;
  String _eqMaterial;
  String _groundMaterial;
  String _location;
  String _lights;
  AboutGymsPage(String name, String adress, String location, String eqMaterial, String groundMaterial, bool lights) {
    this._name = name;
    this._adress = adress;
    this._location = location;
    this._eqMaterial = eqMaterial;
    this._groundMaterial = groundMaterial;
    if(lights) {
      this._lights = 'Yes';
    } else if(!lights) {
      this._lights = 'No';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        title: Text(_name),
      ),
      body: Column(

        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
          child: Text('About', style: TextStyle(
            color: Colors.white,
            fontSize: 45
          ),
          ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Quick facts:', style: TextStyle(
              color: Colors.white,
            ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25, top: 5),
            child: Text(
            'Adress: ' + _adress, style: TextStyle(
            color: Colors.white,
          ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25, top: 5),
          child: Text(
            'Lights: ' + _lights, style: TextStyle(
            color: Colors.white,
          ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25, top: 5),
          child: Text(
            'Equipment material: ' + _eqMaterial, style: TextStyle(
            color: Colors.white,
          ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25, top: 5),
          child: Text(
            'Ground material: ' + _groundMaterial, style: TextStyle(
            color: Colors.white,
          ),
          ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 25, top: 5),
          child: Text(
            'Location: ' + _location, style: TextStyle(
            color: Colors.white,
          ),
          ),
          ),
          Container(
            padding: EdgeInsets.only(top: 40),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {},
              child: Text(
                'Busy hours', style: TextStyle(

              )
              ),
            ),
          )
        ],
      ),
    );
  }
}