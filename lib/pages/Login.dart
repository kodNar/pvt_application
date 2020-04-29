import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/pages/MenuPage.dart';
import 'package:flutterapp/pages/Register.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/pages/ResetPassword.dart';
import 'package:flutterapp/services/DatabaseTestPage.dart';

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
          height: MediaQuery.of(context).size.height/10 *7,
          padding: EdgeInsets.all(20),
          color: Color.fromARGB(255, 132, 50, 155),
          child: Column(
            children: <Widget>[
              Text("AppName",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Stockholm',
                      fontStyle: FontStyle.italic,
                      fontSize: 30)),
              Container(
                margin: EdgeInsets.all(10.0),
                height: 125,
                width: 125,
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
                width: 250,
                height: 55,
                child: RaisedButton(
                  color: Color.fromARGB(255, 0, 110, 191),
                  onPressed: signIn,
                  child: Text('Login'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResetPassword())); /*ResetPassword()*/
                  },

                  // ignore: unnecessary_statements
                  child: Text(
                    'Forgot password?',
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
                    'Create account',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height/10*2,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Stockholm_endast_logga_vit.png'),
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
