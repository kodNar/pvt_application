import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();

}

class _RegisterState extends State<Register>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 50, 155),
        appBar: AppBar(title: Text("Register")),

        body: Form(
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
                  decoration: InputDecoration(
                    labelText: 'E-mail:',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Nickname:',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Password:',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Confirm password:',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                ),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
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


}