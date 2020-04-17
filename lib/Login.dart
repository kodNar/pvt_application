import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/MenuPage.dart';
import 'package:flutterapp/Register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login here"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Color.fromARGB(255, 132, 50, 155),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                // ignore: missing_return
                validator: (input){
                  if(input.isEmpty){ //Check if auth sign or something
                    return 'Please provide an Email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                // ignore: missing_return
                validator: (input){
                  if(input.isEmpty){
                    return 'Please provide a password';
                  }
                  if(input.length < 6){
                    return 'Your password must be atleast 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )
                ),

                obscureText: true, //Döljer texten
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
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder:(context) => Register() ));
                  },
                  child: Text('No account? Click here',
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


  Future<void> signIn() async {

    final formState = _formKey.currentState;

    if (formState.validate()) { //Checks so that the inputs are correct
      formState.save(); //ser till att vi kan hämta variablerna.

      try {
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password); //Confirming the e-mail and password towards the firebase database
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));

      } catch (e) {
        print(e.message);
      }
    }
  }
}