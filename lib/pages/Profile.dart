import 'package:cloud_firestore/cloud_firestore.dart';
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
  final textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Center(
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
                  padding: EdgeInsets.all(35),
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 75.0,
                      backgroundColor: Color(0xFF84329b),
                      backgroundImage: ExactAssetImage(
                          'assets/images/profilePictureTemplate.png'),
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Nickname: ',
                                        style: TextStyle(
                                          fontFamily: 'Agency',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$_nickname',
                                        style: TextStyle(
                                          fontFamily: 'Agency',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Email: ',
                                        style: TextStyle(
                                          fontFamily: 'Agency',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$_email',
                                        style: TextStyle(
                                          fontFamily: 'Agency',
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}",
                                  style: Theme.of(context).textTheme.headline);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      Row(
                        children: const <Widget>[
                          Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 30.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          Text(
                            "27",
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
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          Text(
                            "2",
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
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5,
                    ),
                  ),
                  child: Text(
                    'User Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 225,
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.transparent,
                    onPressed: () {
                      changeNicknameDialog();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Change nickname',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 225,
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.transparent,
                    onPressed: () {
                      changeEmailDialog();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Change email',
                      style: TextStyle(
                          color: Colors.white,
                        fontSize: 18,

                      ),
                    ),
                  ),
                ),
                Container(
                  width: 225,
                  padding: EdgeInsets.all(8),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.transparent,
                    onPressed: () {
                      changePasswordDialog();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Change password',
                      style: TextStyle(color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeNicknameDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text("Current nickname: $_nickname"),
            content: TextFormField(
              validator: (input) => NicknameValidator.validate(input),
              controller: textController,
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text("change"),
                onPressed: () {
                  final formState = _formKey.currentState;
                  if (formState.validate()) {
                    formState.save();
                    updateNickname(textController.text);
                    Navigator.of(context).pop();
                  }
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  void changeEmailDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Current email: $_email"),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("change"),
              onPressed: () {
                updateEmail(textController.text);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void changePasswordDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Enter new password here"),
          content: TextField(
            obscureText: true,
            controller: textController,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("change"),
              onPressed: () {
                updatePassword(textController.text);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void updateNickname(String _nickname) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid).updateNickname(_nickname);
  }

  void updateEmail(String _email) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid).updateEmail(_email);
    user.updateEmail(_email);
  }

  void updatePassword(String _password) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.updatePassword(_password);
  }

  Future<String> printNickname() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String nickNameFromDB = await DatabaseService(uid: user.uid).getNickname();
    _nickname = nickNameFromDB;
    return nickNameFromDB;
  }

  Future<List<String>> getUserdata() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    List<String> userDataList =
        await DatabaseService(uid: user.uid).getUserData();
    _nickname = userDataList[0];
    _email = userDataList[1];
    return userDataList;
  }
}

class NicknameValidator {
  static String validate(String input) {
    if (input.isEmpty) {
      return 'Your nickname cant be empty';
    }
    if (input.length > 15) {
      return 'Your nickname is to long <15';
    }
    if (input.contains(" ")) {
      return 'No spaces allowed in the nickname';
    }
    ///Null does not mean the name will become null.
    return null;

  }
}

class EmailFieldValidator {
  static String validate(String input) {
    return input.isEmpty ? 'Please provide an Email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String input) {
    if (input.length > 0 && input.length < 6) {
      return 'The password needs to be at least 6 characters';
    }
    return input.isEmpty ? 'Please provide a password' : null;
  }
}
