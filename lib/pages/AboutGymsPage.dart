import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



///Allt på denna sida är för närvarande placeholders, allt kommer fortsätta vara placeholders tills hämtning av all data i konstruktorn lösts
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
      this._lights = 'yes';
    } else if(!lights) {
      this._lights = 'no';
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
          Text('About', style: TextStyle(
            color: Colors.white,
          ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Quick facts:', style: TextStyle(
              color: Colors.white,
            ),
            ),
          ),
          Text(
            'Adress: ' + _adress, style: TextStyle(
            color: Colors.white,
          ),
          ),
          Text(
            'Lights: ' + _lights, style: TextStyle(
            color: Colors.white,
          ),
          ),
          Text(
            'Equipment material: ' + _eqMaterial, style: TextStyle(
            color: Colors.white,
          ),
          ),
          Text(
            'Ground material: ' + _groundMaterial, style: TextStyle(
            color: Colors.white,
          ),
          ),
          Text(
            'Location: ' + _location, style: TextStyle(
            color: Colors.white,
          ),
          ),
          Container(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {},
              child: Text(
                'Busy hours', style: TextStyle(
                color: Colors.white,
              )
              ),
            ),
          )
        ],
      ),
    );
  }

}