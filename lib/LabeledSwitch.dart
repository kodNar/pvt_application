import 'package:flutter/material.dart';
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
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState('test', false);
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  _MyStatefulWidgetState(String label,bool _isSelected){
    this.label = label;
    this._isSelected = _isSelected;
  }
  bool _isSelected = false;
  String label;


  @override
  Widget build(BuildContext context) {
    return LabeledSwitch(
      label: label,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}