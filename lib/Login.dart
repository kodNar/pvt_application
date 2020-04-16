import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input.isEmpty){ //Check if auth sign or something
                return 'Please provide an Email';
                }
                return 'Hej';
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'Please provide a password';
                }
                if(input.length < 6){
                  return 'Your password must be atleast 6 characters';
                }
                return 'Welcome';
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true, //Döljer texten
            ),
            RaisedButton(
              onPressed: (){},
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }
Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save(); //ser till att vi kan hämta variablerna.
      FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
    }
    //TODO validate fields

}

}