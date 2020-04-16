import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();

}

class _RegisterState extends State<Register>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: AppBar(title: Text("blyat"))
    );
  }


}