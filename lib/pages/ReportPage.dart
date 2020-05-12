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
import 'package:flutterapp/pages/AboutUs.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';


String picPath = 'assets/images/bok.png';

class ReportPage extends StatefulWidget{
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State <ReportPage>  {
  final List<OutdoorGym> allOutdoorGym = MapSampleState.allOutdoorGym;
  List<DropdownMenuItem<OutdoorGym>> dropDownMenuItems;
  OutdoorGym selectedGym;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
//  bool mounted = false;
  var ImagePath;

  @override
  void initState(){

  }

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(title: const Text('Report / Contact'),
          actions: <Widget>[
          // action button
          IconButton(
          icon: Icon(Icons.home),
      onPressed: () {
            picPath = 'assets/images/bok.png';
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MapSample()
        ));
      },
    ),
    ]

      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: Colors.white,
                width: 300,

                child: MyStatefulWidget(),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                   ButtonTheme(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                     ),
                     buttonColor: Colors.orange,
                     child: RaisedButton(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           Text('Take a Picture'),
                           Icon(Icons.camera_alt),
                         ],
                       ),
                       onPressed: (){
                         main2(context);

                       },
                     ),
                   ),

                    Container(

                      //sök här
                      width: 200,
                      height: 200,
                      child: Image.file(File(picPath)),

                    ),
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
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

      icon: Icon(Icons.arrow_drop_down),

      iconEnabledColor: Colors.black,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),

      underline: Container(
        height: 2,
        color: Colors.white,
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
          child: Text(value, style: TextStyle(
            color: Colors.black
            ),
          ),
        );
      }).toList(),
    );
  }
}

//////////////////////////////////// CAMERA ////////////////////////////////////

Future<void> main2(context) async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  Navigator.push(context, MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera) )); /// Sätt din testsida här! ///
  //TakePictureScreen(camera: firstCamera);
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);
            picPath = path;

            print(picPath.toString());


            // If the picture was taken, display it on a new screen.
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );*/
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ReportPage()
            )
            );

          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
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
