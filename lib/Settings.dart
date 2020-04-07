import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LabeledSwitch.dart';

class Settings extends StatelessWidget {
  LabeledSwitch fastSetting = LabeledSwitch();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text('Settings'),
          actions: <Widget>[
          ]
      ),
      body:

      ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(

            child:
            MyStatefulWidget(),
          ),
          Container(
              child:
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Deliver features faster', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain, // otherwise the logo will be tiny
                      child: const FlutterLogo(),
                    ),
                  ),
                ],
              )
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.pop(context);
        },


        child: Icon(Icons.save)
      ),
    );
  }
}
