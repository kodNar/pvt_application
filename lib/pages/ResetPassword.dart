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
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
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
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
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
            margin: EdgeInsets.only(top: 40),
            height: 50,
            width: 225,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 2.5),
              ),
              color: Colors.blue,
              onPressed: reset,
              child: Text(
                "Send",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/Stockholm_endast_logga_vit.png'
                ),
              ),
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