import 'package:flutter/material.dart';
import 'package:flutterapp/pages/WorkoutPortal.dart';

import 'MapsTest.dart';

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Center(
            child: Text(
              'Workout log',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => WorkoutPortal()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 40,
            semanticLabel: 'Back',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 40,
              color: Colors.black,
            ),
            tooltip: 'Go to homepage',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapSample()));
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      body: Form(
        child: Column(
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Color(0xFF42A5F5),
        icon: const Icon(Icons.add),
        label: const Text('Add exercise/equipment'),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                iconSize: 40,
                onPressed: () {},
              ),

              IconButton(
                icon: Icon(Icons.save),
                color: Colors.green,
                iconSize: 40,
                onPressed: () {},
            ),
          ],
        ),
      ),

    );
  }
}
