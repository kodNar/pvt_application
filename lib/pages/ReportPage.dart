import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:flutterapp/FaultyEquipmentReport.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/services/camera/camera.dart';
import 'package:flutterapp/pages/AboutUs.dart';
import 'package:camera/camera.dart';



class ReportPage extends StatelessWidget {
  final List<OutdoorGym> allOutdoorGym = MapSampleState.allOutdoorGym;
  List<DropdownMenuItem<OutdoorGym>> dropDownMenuItems;
  OutdoorGym selectedGym;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
//  bool mounted = false;
  var ImagePath;


  void initState(){
    dropDownMenuItems = buildDropDownMenuItems(allOutdoorGym);
    selectedGym = dropDownMenuItems[0].value;
    @override
    void initState() {
      super.initState();
      // 1
      availableCameras().then((availableCameras) {

        cameras = availableCameras;
        if (cameras.length > 0) {
          setState(() {
            // 2
            selectedCameraIdx = 0;
          });

          _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
        }else{
          print("No camera available");
        }
      }).catchError((err) {
        // 3
        print('Error: $err.code\nError Message: $err.message');
      });
    }
  }

//  Future<void> _initializeCamera() async {
//    final cameras = await availableCameras();
//    final firstCamera = cameras.first;
//    _controller = CameraController(firstCamera,ResolutionPreset.high);
//    _initializeControllerFuture = _controller.initialize();
//    if (!mounted) {
//      return;
//    }
//    setState(() {
//      isCameraReady = true;
//    });
//  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }



  List<DropdownMenuItem<OutdoorGym>> buildDropDownMenuItems(List gyms){
    List<DropdownMenuItem<OutdoorGym>> items = List();
    for(OutdoorGym gym in allOutdoorGym){
      items.add(
          DropdownMenuItem(
            value: gym,
            child: Text(gym.name),
          ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
//    initState();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(title: const Text('Report Page'),


      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(

          ),
          Container(
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));},
                ),
                Container(

                )
              ],
            )

          ),
          Container(
            child: Text('Open Comments', style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            ),
          ),
          Container(

            child: TextField(

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                prefixIcon: Icon(Icons.description),
                hintText: "Describe your issue",
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black38,
              // ignore: missing_return
//              validator: (input) {
//                if (input.isEmpty) {
//                  return 'Please provide a short description';
//                }
//              },

            ),
          ),
          Container(

            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  colors: <Color>[
                    Color(0xFFF57C00),
                    Color(0xFFFF9800),
                    Color(0xFFFFA726),
                  ],
                ),
              ),
              child: Text('Send',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  )),
            ),
          )
        ]
    ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,

      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

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


