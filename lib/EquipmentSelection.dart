import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EquipmentSelection {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  //TODO Ta bort entries, för att sedan hämta en samling equipment, colorCodes behövs ej

/*
Skapar en ListView.builder, en oändligt stor lista som läser in och skapar knappar
utifrån en intagen lista.
 */
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Select your equipment'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(child: Text('Entry ${entries[index]}')),
                //TODO Se till att den skapar knappar från en hämtad samling
              );
            }));
  }
}
