import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/MenuPage.dart';
import 'package:flutterapp/pages/TestPage.dart';
import 'package:flutterapp/services/DatabaseTestPage.dart';
import 'Register.dart';
import 'ResetPassword.dart';
import 'Settings.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/pages/EquipmentSelection.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailFieldValidator {
  static String validate(String input) {
    if(!input.contains("@") && input.isNotEmpty){
      return 'Your email must contain @';
    }
    if(input.length <= 3 && input.length > 0){
      return 'Please provide a real Email this Email is to short';
    }
    if(input.length > 100){
      return 'That email is too long use another one';
    }
    return input.isEmpty ? 'Please provide an Email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String input) {
    if (input.length > 0 && input.length < 8) {
      return 'The password needs to be at least 8 characters';
    }
    return input.isEmpty ? 'Please provide a password' : null;
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool isLoggedIn = false;
  Map userProfile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              width: size.width,
              height: size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Stockholm Outdoor Gyms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Stockholm',
                        fontStyle: FontStyle.normal,
                        fontSize: 35),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/applogga_vit_liten.png'),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.white,
                            // ignore: missing_return
                            validator: (input) =>
                                EmailFieldValidator.validate(input),
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: Colors.white,
                            // ignore: missing_return
                            validator: (input) =>
                                PasswordFieldValidator.validate(input),
                            onSaved: (input) => _password = input,
                            obscureText: true, //Döljer texten
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*
                  CheckboxListTile(
                    title: Text(
                      "Remember login",
                      style: TextStyle(color: Colors.white),
                    ),
                    activeColor: Colors.green,
                    value: true,
                    onChanged: (newValue) {},
                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                  ),

                   */
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 250,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color.fromARGB(255, 0, 110, 191),
                        onPressed: signIn,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,

                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () => initiateGoogleLogin(),
                          child: Image.asset(
                            'assets/images/googleLoggaKnapp.png',
                            width: 180,
                            height: 50,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () => initiateFacebookLogin(),
                          child: Image.asset(
                            'assets/images/facebookLoggaKnapp.png',
                            width: 180,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()));
                      },
                      // ignore: unnecessary_statements
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    width: 175,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 132, 50, 155),
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/StockholmStadLogga.png'),
                      ),
                    ),
                  ),

                  /*
              BottomAppBar(
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
                    Text("Stockholms Stad",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Stockholm',
                          fontStyle: FontStyle.italic,
                          fontSize: 29.0),
                    ),
                  ],
                ),
              ),
              */
/*
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestPage()));
                      },
                      child: Text(
                        'Testknappar',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


 */
                ],
              ),
            ),
          ),
        ));
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
        isLoggedIn = true;
        goToHomePage();
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

    GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn(); //Här den felar

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult user = await _auth.signInWithCredential(credential);
    isLoggedIn = true;
    goToHomePage();
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

  void goToHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapSample()));
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      //Checks so that the inputs are correct
      formState.save(); //ser till att vi kan hämta variablerna.
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        String uid = result.user.uid;
        //hej

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapSample(),
              settings: RouteSettings(name: '/MapSample')),
        );

      } catch (e) {
        Fluttertoast.showToast(
            msg: "Invalid credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print(e.message);
      }
    }
  }
}
