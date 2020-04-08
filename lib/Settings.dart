import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LabeledSwitch.dart';

class Settings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Settings'),
            actions: <Widget>[]),
        body: Builder(builder: (context) {
          return Stack(
            children: [
              Container(
                child:
                ListView(
                  children: <Widget>[
                    Container(
                      child: MyStatefulWidget(),
                    ),
                    Container(
                      child: MyTextInput(),
                      height: 60,
                    ),
                    Container(
                      child: MyStatefulWidget2(),
                    ),
                  ],
                ),

              ),
              Container(
                alignment: Alignment.bottomRight,
                  padding:EdgeInsets.all(20.0),
                  child:
                  SnackBarPage()
              ),
              ]
          );
        }));
  }
}


/////////////////Code for input textField////////////////////////////////////////
class MyTextInput extends StatefulWidget {
  @override
  _MyTextInput createState() => _MyTextInput();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyTextInput extends State<MyTextInput> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
        controller: myController,
        onChanged: (String str) {
          setState(() {
            //save the input
          });
        });
  }
}

//////////////////////////////////////////////////////////////////
////////////////////snackbar code///////////////////////////////////////////
class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Save"),
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Saved!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),

          );

          Scaffold.of(context).showSnackBar(snackBar);
          Icon(Icons.check);
        },
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////
