import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/Database.dart';
import 'package:flutterapp/widgets/Appbar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _nickname, _email;
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
                    FutureBuilder(
                        future: getUserdata(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nickname: $_nickname',
                                  style: TextStyle(
                                    fontFamily: 'Agency',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Email: $_email',
                                  style: TextStyle(
                                    fontFamily: 'Agency',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}",style: Theme.of(context).textTheme.headline);
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
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
  Future<String> printNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String nickNameFromDB = await DatabaseService(uid: user.uid).getNickname();
    _nickname = nickNameFromDB;
    return nickNameFromDB;
  }

  Future<List<String>> getUserdata() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<String> userDataList = await DatabaseService(uid: user.uid).getUserData();
    _nickname = userDataList[0];
    _email = userDataList[1];
    return userDataList;
  }


}
