import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutterapp/pages/MapsTest.dart';
import 'package:flutterapp/OutdoorGym.dart';
import 'package:flutterapp/Equipment.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutterapp/pages/WorkoutGymList.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'ReportPageEquipmentList.dart';
import 'package:fluttertoast/fluttertoast.dart';

String picPath = 'assets/images/bok.png';
bool gymChosen = false;
bool eqChosen = false;
String description;

String equipment = 'Not Specified';
OutdoorGym outdoorGym;
enum SingingCharacter { error, suggestion }
//kommentar

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  final List<OutdoorGym> allOutdoorGym = MapSampleState.allOutdoorGym;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool buttonDisabled = true;


  @override
  void initState() {}

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  void disableButton(){
    if (description == null || outdoorGym == null){
      buttonDisabled = true;
    }
    else{
      buttonDisabled = false;
    }
  }

  SingingCharacter _radioChoice = SingingCharacter.error;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 50, 155),
      appBar: AppBar(title: const Text('Report / Contact'), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MapSample()));
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(

            key: _formKey,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 75),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Error Report',style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                        leading: Radio(
                          activeColor: Colors.white,
                          focusColor: Colors.white,

                          value: SingingCharacter.error,
                          groupValue: _radioChoice,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              _radioChoice = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Suggestion',style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                        leading: Radio(
                          activeColor: Colors.white,
                          focusColor: Colors.white,
                          value: SingingCharacter.suggestion,
                          groupValue: _radioChoice,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              _radioChoice = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                child: gymReturn(),
              ),
              Container(
                child: eqReturn(),
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
                          onPressed: () {
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
                  )),
              Container(
                child: Text(
                  'Open Comments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: myController,
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

                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 100,
                child: ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white, width: 1.5),
                  ),

                  child: RaisedButton(

                    color: Colors.transparent,
                    child: Text('Send',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      description = myController.text;
                      disableButton();
                      if(!buttonDisabled) {

                        main();
                        thankYouMessage();

                      }else{
                        Fluttertoast.showToast(
                            msg: "Please select a gym and provide a short description",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                  ),
                ),
              )
            ]),
      ),
    );
  }

  Widget gymReturn() {
    if (gymChosen) {
      return Container(
        padding: EdgeInsets.all(20),
        child: ButtonTheme(
          minWidth: 250,
          height: 48,
          child: RaisedButton(
            //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            color: Colors.transparent,
            onPressed: () {
              _pushContextChooseGym(context);
            },
            child: Text(
              outdoorGym.name,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: ButtonTheme(
          minWidth: 250,
          height: 48,
          child: RaisedButton(
            //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            color: Colors.transparent,
            onPressed: () {
              _pushContextChooseGym(context);
            },
            child: Text(
              'Choose gym',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget eqReturn() {
    if (eqChosen) {
      return Container(
        padding: EdgeInsets.all(20),
        child: ButtonTheme(
          minWidth: 250,
          height: 48,
          child: RaisedButton(
            //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            color: Colors.transparent,
            onPressed: () {
              _pushContextChooseGym(context);
            },
            child: Text(
              equipment,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: ButtonTheme(
          minWidth: 250,
          height: 48,
          child: RaisedButton(
            //Gör knappen till en cirkel och sätter dit en grön border för tydlighet
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            color: Colors.transparent,
            onPressed: () {
              _pushContextChooseEq(context);
            },
            child: Text(
              'Choose Equipment',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  _pushContextChooseGym(BuildContext context) async {
    final OutdoorGym result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkoutGymList()));
    gymChosen = true;
    outdoorGym = result;
  }

  _pushContextChooseEq(BuildContext context) async {
    final Equipment result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReportPageEquipmentList(outdoorGym)));
    eqChosen = true;
    equipment = result.getName();
  }

  void thankYouMessage(){

    Fluttertoast.showToast(
        msg: "Thank you for your input! We will look into the matter ASAP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0

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

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: firstCamera)));



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

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ReportPage()));
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

///////////////////////////////////EMAIL///////////////////////////////////////////

main() async {

  gymChosen = false;
  eqChosen = false;
  String userName = 'apikey';
  String passWord =
      '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';
  final smtpServer =
  SmtpServer('smtp.sendgrid.net', username: userName, password: passWord);

  Message message = new Message();

  if(picPath != 'assets/images/bok.png') {
    message = Message()


      ..from = Address('simon.schoolsoft@gmail.com', 'Simon')
      ..recipients.add('simon.schoolsoft@gmail.com')
      ..subject = 'Outdoor Gym Error Report ${DateTime.now()}'
      ..text = ('Gym: ' + outdoorGym.name + '\n' + 'Equipment: ' +
          equipment + '\n' + '\n' + description)
      ..attachments.add(new FileAttachment(File('$picPath')));
  }else{
    message = Message()
      ..from = Address('simon.schoolsoft@gmail.com', 'Simon')
      ..recipients.add('simon.schoolsoft@gmail.com')
      ..subject = 'Outdoor Gym Error Report ${DateTime.now()}'
      ..text = ('Gym: ' + outdoorGym.name + '\n' + 'Equipment: ' +
          equipment + '\n' + '\n' + description);

  }



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