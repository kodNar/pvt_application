import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();

}

class _RegisterState extends State<Register>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _nickName, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(title: Text("Register")),

      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                ),
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please provide an Email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'E-mail:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
             /* TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please provide an nickname';
                  }
                },
                onSaved: (input) => _nickName = input,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Nickname:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),

                ),
              ),*/
              TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please provide a password';
                  }
                },
                onSaved: (input) => _password = input,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Password:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                obscureText: true,
              ),

             /* TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                validator: (input) {
                  if (_password.length < 3) {
                    return 'Please repeat your password';
                  }
                },
                //onSaved: (input) => _password = input,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Confirm password:',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),

                ),
                obscureText: true,
              ),*/
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  minWidth: 100,
                  height: 75,
                  child: RaisedButton(
                    //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white, width: 2.5),
                    ),
                    color: Colors.transparent,
                    onPressed: register,

                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
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

  Future<void> register() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(password: _password, email: _email);
        user.user.sendEmailVerification();
        Navigator.of(context).pop();
      }catch(e){
        print(e.message);
      }
    }
  }
}