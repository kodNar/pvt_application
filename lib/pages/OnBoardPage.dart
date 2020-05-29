import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';
import 'package:path/path.dart';

class OnBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: BaseAppBar(
        title: 'App Tutorial',
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 75,
                width: 75,
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 132, 50, 155),
                        image: DecorationImage(
                          image: AssetImage('assets/images/onBoardPic1.jpg'),
                          fit: BoxFit.fill,
                        )
                    )),
              ),
              Container(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  children: <Widget>[
                    Text('1. Find your next outdoor gym visit in the map!', style:
                    TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    Text('\nOn the main page, you can find all the\navailable gyms, either on the map or in the list.')
                  ],
                ),
              ),

            ],
          ),
          Text(
            '\n\n2. See popular hours in order to plan your visit!\n',
            style:
            TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 50),
              child: Text(
                '1. Select a gym of your choice.\n'
                    '2. In the gyms menu,click on\n"Popular Hours".',
              ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/onBoardPic2.jpg'),
                    )
                ),
              ),
            ],
          ),
          Text(
            '\n\n3. Log your workout!\n',
            style:
            TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onBoardPic3.jpg'),
                  )
                ),
              ),
              Text(
                "1. If you haven't, start by creating an account\n"
                '2. Choose  "New Workout" from the menu\n'
                    '3. Click "Log New Workout"\n'
                    '4. Choose your Gym\n'
                    '5. "Add exercise" and get started!'
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Text('4 Share, like and be inspired in the app!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/onBoardPic4.jpg'),
                  )
                ),
              ),
            ],
          ),
          Container(

            child: Text(
              "1. When you're about to Save your workout, you can share\n"
                  ' your workout with the option "Save and Share"\n'
                  '2. Your workout log is now posted on "Discover workout"\n'
                  ' for others to view, like and collect.\n'
                  '\nThank you for sharing and inspiring others!'
            ),
          )
        ],
      )
    );
  }

}