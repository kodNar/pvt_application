import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final globalKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Settings'),
            actions: <Widget>[]),
        body: Builder(builder: (context) {
          return Stack(children: [
            Container(
              child: ListView(
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
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text('Reset Settings'),
                  )),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20.0),
                child: SnackBarPageSaved()),
          ]);
        }));
  }
}

///////////////////////Code for input textField/////////////////////////
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
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Weight',
        ),
        controller: myController,
        onChanged: (String str) {
          setState(() {
            //skriv kod för att spara texten
            dispose();
          });
        });
  }
}

////////////////////snackbar code///////////////////////////////////////////
class SnackBarPageSaved extends StatelessWidget {
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

//////////////////////////Pop-up box reset/////////////////////////////////////////////
showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget yesButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      final snackBar = SnackBar(content: Text('Settings has been reset'));
      Scaffold.of(context).showSnackBar(snackBar);
      // to-do reset settings
      Navigator.of(context).pop();
    },
  );
  Widget noButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Are you sure that you want to reset your settings?"),
    actions: [
      yesButton,
      noButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/////////////////////////////////LabeldSwitch///////////////////////////////////
class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Switch(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
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
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return LabeledSwitch(
      label: 'SlowMode',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}

class MyStatefulWidget2 extends StatefulWidget {
  MyStatefulWidget2({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState2 createState() => _MyStatefulWidgetState2();
}

class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LabeledSwitch(
      label: 'FastMode',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}
