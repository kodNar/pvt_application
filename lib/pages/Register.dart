import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/WorkoutSession.dart';
import 'package:flutterapp/services/Database.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();

}

class _RegisterState extends State<Register>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _nickName, _password, _confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(title: Text("Register")),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
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
                ///En klickbar ikon som visar texten om att e-posten ej kommer nyttjas i reklamsyfte
                IconButton(
                  padding: EdgeInsets.only(left: 330),
                  icon: Icon(
                    Icons.help,
                  ),
                  color: Colors.white,
                  tooltip: 'Your e-mail will not be used for advertising. It will strcitly be used to reset your password',
                  onPressed: () {
                  },
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    ///Textfält samt kontroller för att en giltig e-post skrivs in
                    // ignore: missing_return
                    validator: (input) {
                      if(input.isEmpty) {
                        return 'Please provide an E-mail';
                      }
                      if(!input.contains('@')) {
                        return 'Please provide a valid E-mail';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    ///Textfält, samt kontroller för att ett godkänt lösenord skrivs in
                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty) {
                        return 'Please provide a password';
                      }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    ///Kontroll så att användaren skrivit in korrekt lösenord (denne behöver skriva in det igen likadant som denne skrev i första fältet
                    // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty) {
                        return 'Please repeat your password';
                      }
                    },
                    onSaved: (input) => _confirmPassword = input,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Confirm password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
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
                Container(
                  padding: EdgeInsets.only(top: 20),
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
          ),
        ),
      ),
    );
  }

  ///Sparar användarens input till strängar och skickar detta till firebase som i sin tur skapar konton som användaren kan nyttja för att logga in.
  Future<void> register() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      if(_password != _confirmPassword) {
        //Popup när lösenord ej matchar
        showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Confirm password"
            ),
            content: Text(
              "The passwords must be matching"
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
        );
      }else if(_password.length <= 8){
        return AlertDialog(
          title: Text(
              "Confirm password"
          ),
          content: Text(
              "The password must be at least 8 characters"
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
      try{
        AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(password: _password, email: _email);
        FirebaseUser user = result.user;
        await DatabaseService(uid: user.uid).updateUserData(user.uid, _email, 'nickName');
        user.sendEmailVerification();
        Navigator.of(context).pop();
      }catch(e){
        print(e.message);
      }
    }
  }
}
