import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class DiscoverWorkouts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar(
        title: ("Discover workouts"),
      ),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          child: RaisedButton.icon(
            color: Color.fromARGB(255, 132, 50, 155),
            onPressed: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPortal()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Upload Your Workout Log',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            Flexible(
             fit: FlexFit.tight,
              child:

              Container(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
//              decoration: BoxDecoration(
//                border: Border.all(
//                  color: Colors.black,
//                )
//              ),

              child:
            RaisedButton.icon(
              onPressed: () {
                //nånting
              },
              color: Color.fromARGB(255, 132, 50, 155),
          icon: Icon(
              Icons.timelapse
          ),
              label: Text(
                "Most Recent",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child:
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
//              decoration: BoxDecoration(
//                  border: Border.all(
//                    color: Colors.black,
//                  )
//              ),
              child:
            RaisedButton.icon(
              onPressed: () {
                //nånting
              },
              color: Color.fromARGB(255, 132, 50, 155),
              icon: Icon(
                  Icons.thumb_up
              ),
              label: Text(
                "Most Recent",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ),
            ),
          ],

          )
        ),
      ],

      )

    );
  }
}