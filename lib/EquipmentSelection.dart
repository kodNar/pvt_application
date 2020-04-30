import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class EquipmentSelection extends StatelessWidget {
  String _name;
  List<String> _equipment = [];

  EquipmentSelection(String name, List<String> equipment) {
    this._name = name;
    this._equipment = equipment;
  }

  /*
  TODO måste hämta equipment när man väl valt gymmet, för att sedan hämta alla övningar som finns på respektive equipment
   */


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text(_name),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _equipment.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Center(child: Text('Entry ${_equipment[index]}')),
              );
            }
        ),
    );
  }
}