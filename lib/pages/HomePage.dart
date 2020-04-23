import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Login.dart';
import 'package:flutterapp/pages/MenuPage.dart';
import 'Settings.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;
  Map userProfile;
  FirebaseAuth mAuth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 132, 50, 155),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ]),
      body: Container(
        padding: EdgeInsets.only(top: 70),
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("AppName",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Stockholm',
                    fontStyle: FontStyle.italic,
                    fontSize: 45)),
            Container(
              margin: EdgeInsets.all(50.0),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/applogga_vit_liten.png'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                onTap: () => initiateGoogleLogin(),
                child: Image.asset(
                  'assets/images/googleLoggaKnapp.png',
                  width: 200,
                  height: 50,
                ),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () => initiateFacebookLogin(),
                child: Image.asset(
                  'assets/images/facebookLoggaKnapp.png',
                  width: 200,
                  height: 50,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150,
                    height: 75,
                    child: RaisedButton(
                      //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white, width: 2.5),
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 150,
                    height: 75,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        //Gör knappen till en cirkel och sätter dit en vit border för tydlighet
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white, width: 2.5),
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuPage()));
                      },
                      child: new Text(
                        'Guest',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 132, 50, 155),
        elevation: 0, //tar bort liten linje
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/Stockholm_endast_logga_vit.png'),
                      fit: BoxFit.fill)),
            ),
            Text(
              "Stockholms Stad",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Stockholm',
                  fontStyle: FontStyle.italic,
                  fontSize: 29.0),
            ),
          ],
        ),
      ),
    );
  }

  //Facebook login
  void initiateFacebookLogin() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        FacebookAccessToken myToken = facebookLoginResult.accessToken;
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: myToken.token);
        AuthResult user = await _auth.signInWithCredential(credential);
    }
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  //Google login
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> initiateGoogleLogin() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn(); //Här den felar

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    AuthResult user = await _auth.signInWithCredential(credential);
    /*
    FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    */

    return 'signInWithGoogle succeeded:';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }
}
