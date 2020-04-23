import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/pages/MenuPage.dart';
import 'package:flutterapp/pages/Register.dart';
import 'package:flutterapp/pages/MapsTest.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login here"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Color.fromARGB(255, 132, 50, 155),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Stockholm_endast_logga_vit.png'),
                  ),
                ),
              ),
              Text("AppName",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Stockholm',
                      fontStyle: FontStyle.italic,
                      fontSize: 30)),
              Container(
                margin: EdgeInsets.all(10.0),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/applogga_vit_liten.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  // ignore: missing_return
                  validator: (input) {
                    if (input.isEmpty) {
                      //Check if auth sign or something
                      return 'Please provide an Email';
                    }
                  },
                  onSaved: (input) => _email = input,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  // ignore: missing_return
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please provide a password';
                    }
                    if (input.length < 6) {
                      return 'Your password must be atleast 6 characters';
                    }
                  },
                  onSaved: (input) => _password = input,
                  obscureText: true, //Döljer texten
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  onPressed: signIn,
                  child: Text('Sign in'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    final formState = _formKey.currentState;
                    formState.save();
                    if (_email.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Failed reset"),
                              content: Text(
                                  "Please input your e-mail in the e-mail field"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                    // ignore: unnecessary_statements
                    else {
                      sendPasswordResetEmail(_email);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Reset password"),
                              content: Text(
                                  "An e-mail to reset your password has been sent to your registered e-mail."),
                              actions: <Widget>[
                                new FlatButton(
                                  child: Text(
                                    "Ok",
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                    ;
                  },
                  child: Text(
                    'Forgot password? Click here',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    'No account? Click here',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //reset password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      //Checks so that the inputs are correct
      formState.save(); //ser till att vi kan hämta variablerna.

      try {
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password:
                _password); //Confirming the e-mail and password towards the firebase database
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapSample()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
