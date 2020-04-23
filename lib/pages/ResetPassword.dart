import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResetPassword extends StatefulWidget {
  @override
  _ResetPassword createState() => new _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(
        title: Text(
          'Reset Password'
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Forgot your password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Text(
              'Please enter your email adress which you registered with and we will send you a link to recover your password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
            )
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'E-mail',
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                //ignore: missing_return
                validator: (input) {
                  if(input.isEmpty) {
                    return 'Please provide an e-mail';
                  }
                  if(!input.contains('@')) {
                    // ignore: unnecessary_statements
                    'Please provide a valid e-mail';
                  }
                },
                onSaved: (input) => _email = input,
              ),
            ),

          ),
          Container(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 2.5),
              ),
              color: Colors.blue,
              onPressed: reset,
            ),
          )
        ],
      ),
    );
  }


  Future<void> reset() async{
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
    }
    await _firebaseAuth.sendPasswordResetEmail(email: _email);
  }
}