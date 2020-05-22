import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profile',
      ),
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF84329b),
                  Color(0xFF84329b),
                  Color(0xFF9438ae),
                  // Color(0xFFa53fc1),
                  Color(0xFFae52c7),
                ]),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundColor: Color(0xFF84329b),
                    backgroundImage: ExactAssetImage('assets/images/profilePictureTemplate.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Nickname: Einar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Email: EinarEdberg@gmail.com',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: Text('Password: ********',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: const <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                       Text("27",
                         style: TextStyle(
                           fontSize: 25,
                           fontWeight: FontWeight.bold,
                         ),
                       ),

                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text("2",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
