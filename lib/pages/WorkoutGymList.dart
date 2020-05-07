import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class WorkoutGymList extends StatefulWidget {
  @override
  _WorkoutGymListState createState() => _WorkoutGymListState();
}

class _WorkoutGymListState extends State<WorkoutGymList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84329b),
      appBar: BaseAppBar(
        title: 'Choose gym',
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('test',

              ),
            ),
          ],
        ),
      ),
    );
  }
}
