import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report an issue',
        ),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(
              'Epost',
            ),
            onPressed: main,
          ),
        ],

      ),
    );
  }
  /*Future<void> email() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
    final Email email = Email(
      body: "There's an issue",
      subject: "Faulty equipment",
      recipients: ['simon.schoolsoft@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }*/


  main() async {
    String userName = 'apikey';
    String passWord = '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';
    final smtpServer = SmtpServer('smtp.sendgrid.net', username: userName, password: passWord);

    final message = Message()
      ..from = Address('simon.schoolsoft@gmail.com', 'Simon')
      ..recipients.add('simon.schoolsoft@gmail.com')
      ..subject = 'Test Dart Mailer library ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';


    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

}
