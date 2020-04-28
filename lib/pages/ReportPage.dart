import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => new _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report an issue',
        ),
      ),
      body: Container(
        width: 250,
        height: 75,
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text(
            'Epost',
          ),
          onPressed: email,
        ),
      ),
    );
  }
  Future<void> email() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
    final Email email = Email(
      body: "There's an issue",
      subject: "Faulty equipment",
      recipients: ['simon.schoolsoft@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);

  }

}